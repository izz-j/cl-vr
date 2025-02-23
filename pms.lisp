;;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-
;;;; ==========================================================================
;;;; pms.lisp --- Process management system. Manages a list with child
;;;; processes
;;;;
;;;; Copyright (c) 2013, Nikhil Shetty <nikhil.j.shetty@gmail.com>
;;;;   All rights reserved.
;;;;
;;;; Redistribution and use in source and binary forms, with or without
;;;; modification, are permitted provided that the following conditions
;;;; are met:
;;;;
;;;;  o Redistributions of source code must retain the above copyright
;;;;    notice, this list of conditions and the following disclaimer.
;;;;  o Redistributions in binary form must reproduce the above copyright
;;;;    notice, this list of conditions and the following disclaimer in the
;;;;    documentation and/or other materials provided with the distribution.
;;;;  o Neither the name of the author nor the names of the contributors may
;;;;    be used to endorse or promote products derived from this software
;;;;    without specific prior written permission.
;;;;
;;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;;;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;;;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;;;; A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
;;;; OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;;;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;;;; LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;;;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;;;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;;;; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;;;; ==========================================================================

(in-package #:cl-vr)

;;; ---------------------------------------------------------------------------
(defparameter *CHILDREN* ())

;;; ---------------------------------------------------------------------------
(defun add-child (pid)
  "Saves the pid into the *CHILDREN* list"
  (push pid *CHILDREN*))

;;; ---------------------------------------------------------------------------
(defun rm-child (pid)
  "Deletes child pid from the *CHILDREN* list"
  (delete pid *CHILDREN*))

;;; ---------------------------------------------------------------------------
(defun wait-for-children ()
  "Loops waits for childrent to terminate. If the child terminates then that
  particular entry is removed from the *CHILDREN* list"
  (dolist (child *CHILDREN*)
    (let ((pid (sb-posix:waitpid child sb-posix:WNOHANG)))
      (when (equal pid child)
        (rm-child pid)))))

;;; ---------------------------------------------------------------------------
(defun print-children ()
  "Lists all the pid inside *CHILDREN*"
  (dolist (child *CHILDREN*)
    (when child (format t "~& ~A ~%" child))))

;;; ---------------------------------------------------------------------------
(defun total-children ()
  "Returns the total number of children in the list"
  (length *CHILDREN*))
