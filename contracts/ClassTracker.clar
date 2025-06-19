;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Attendance Tracker Smart Contract
;; Author: ChatGPT
;; Purpose: Allow a teacher to mark students as present
;; and allow anyone to check student attendance.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Store contract deployer as the teacher (admin)
(define-constant contract-owner tx-sender)

;; Map to store attendance records
(define-map attendance
  {student: principal}
  {present: bool}
)

;; Variable to track the last marked student
(define-data-var last-marked-student (optional principal) none)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PUBLIC FUNCTION: mark-present
;; Only the contract owner can mark a student present
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-public (mark-present (student principal))
  (begin
    ;; Ensure only the teacher can call this
    (asserts! (is-eq tx-sender contract-owner) (err "Only teacher can mark attendance"))
    
    ;; Save presence to map using checked principal
    (let 
      ((student-attendance {student: student}))
      (map-set attendance student-attendance {present: true})
    )
    
    ;; Return success
    (ok true)
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; READ-ONLY FUNCTION: is-present
;; Returns true or false for student attendance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-read-only (is-present (student principal))
  (let ((record (map-get? attendance {student: student})))
    (match record
      entry (get present entry)
      false)
  )
)
