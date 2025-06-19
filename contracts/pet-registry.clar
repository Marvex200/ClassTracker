;; Pet Adoption Smart Contract
;; Purpose: Register pets and allow users to adopt them

(define-data-var pet-id-counter uint u0)

;; Each pet has a name, breed, and optional adopter
(define-map pets
  { id: uint }
  { name: (string-ascii 20), breed: (string-ascii 20), adopted-by: (optional principal) }
)

;; Events are emitted using the 'print' statement in Clarity.

;; Public function to register a new pet
(define-public (register-pet (name (string-ascii 20)) (breed (string-ascii 20)))
  (let ((new-id (+ (var-get pet-id-counter) u1)))
    (begin
      (map-set pets {id: new-id} {
        name: name,
        breed: breed,
        adopted-by: none
      })
      (var-set pet-id-counter new-id)
      (print {
        event: "pet-registered",
        id: new-id,
        name: name,
        breed: breed
      })
      (ok new-id)
    )
  )
)

;; Public function to adopt a pet
(define-public (adopt-pet (pet-id uint))
  (match (map-get? pets {id: pet-id})
    pet
    (begin
      (if (is-some (get adopted-by pet))
        (err "Pet already adopted")
        (begin
          (map-set pets {id: pet-id} {
            name: (get name pet),
            breed: (get breed pet),
            adopted-by: (some tx-sender)
          })
          (print {
            event: "pet-adopted",
            id: pet-id,
            adopter: tx-sender
          })
          (ok "Adopted successfully")
        )
      )
    )
    (err "Pet not found")
  )
)

;; Read-only function to get a pet's information
(define-read-only (get-pet (pet-id uint))
  (map-get? pets {id: pet-id})
)

;; Read-only function to get the number of registered pets
(define-read-only (get-total-pets)
  (ok (var-get pet-id-counter))
)
