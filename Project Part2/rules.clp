;;rules for security evaluation

;;rules for anitvirus metrics
(deftemplate antivirus (slot value))
(defglobal ?*anti* = "0")
(defrule yesanti
(antivirus (value ?v&: (eq ?v Windows)))
    =>
   (bind ?*anti* 100)
    )

(defrule thirdanti
(antivirus (value ?v&: (eq ?v Third)))
    =>
   (bind ?*anti* 100)
    )
(defrule noanti
(antivirus (value ?v&: (eq ?v None)))
	=>
	(bind ?*anti* 30)
	)

;;rules for browser metric
(deftemplate browser (slot value))
(defglobal ?*brow* = "0")
(defrule mozbrow
  (browser (value ?v&: (eq ?v Mozilla)))
    =>
   (bind ?*brow* 80)
    )

(defrule edgebrow
  (browser (value ?v&: (eq ?v Edge)))
    =>
   (bind ?*brow* 60)
    )
(defrule safaribrow
  (browser (value ?v&: (eq ?v Safari)))
	=>
	(bind ?*brow* 80)
	)
(defrule chromebrow
  (browser (value ?v&: (eq ?v Chrome)))
	=>
	(bind ?*brow* 100)
	)
(defrule otherbrow
  (browser (value ?v&: (eq ?v Other)))
	=>
	(bind ?*brow* 30)
	)

;;rules for firewall metric
(deftemplate firewall (slot value))
(defglobal ?*firew* = "0")
(defrule yesfirewall
  (firewall (value ?v&: (eq ?v Yes)))
    =>
   (bind ?*firew* 100)
    )

(defrule nofirewall
  (firewall (value ?v&: (eq ?v No)))
    =>
   (bind ?*firew* 20)
    )

;;rules for no. of users metric
(deftemplate noofusers (slot value))
(defglobal ?*nou* = "0")
(defrule 1nou
  (noofusers (value ?v&: (eq ?v 1)))
    =>
   (bind ?*nou* 100)
    )

(defrule 2nou
  (noofusers (value ?v&: (eq ?v 2)))
    =>
   (bind ?*nou* 80)
    )
(defrule 3nou
  (noofusers (value ?v&: (eq ?v 3)))
	=>
	(bind ?*nou* 60)
	)
(defrule 4nou
  (noofusers (value ?v&: (eq ?v 4)))
	=>
	(bind ?*nou* 40)
	)
(defrule 5nou
  (noofusers (value ?v&: (eq ?v 5)))
	=>
	(bind ?*nou* 30)
	)
(defrule 6nou
  (noofusers (value ?v&: (eq ?v 6)))
	=>
	(bind ?*nou* 20)
	)
(defrule morenou
  (noofusers (value ?v&: (eq ?v More)))
	=>
	(bind ?*nou* 5)
	)

;; rules for passwarod metric
(deftemplate password (slot value))
(defglobal ?*passwd* = "0")
(defrule yespasswd
  (password (value ?v&: (eq ?v Yes)))
    =>
   (bind ?*passwd* 100)
    )

(defrule nopasswd
  (password (value ?v&: (eq ?v No)))
    =>
   (bind ?*passwd* 20)
    )

;;rules for security patch metric
(deftemplate security (slot value))
(defglobal ?*secure* = "0")
(defrule yessecure
  (security (value ?v&: (eq ?v Yes)))
    =>
   (bind ?*secure* 100)
    )

(defrule nosecure
  (security (value ?v&: (eq ?v No)))
    =>
   (bind ?*secure* 10)
    )
;;rules for operating system metric
(deftemplate system (slot value))
(defglobal ?*sys* = "0")
(defrule winsys
  (system (value ?v&: (eq ?v Windows)))
    =>
   (bind ?*sys* 90)
    )

(defrule macsys
  (system (value ?v&: (eq ?v Mac)))
    =>
   (bind ?*sys* 100)
    )

(defrule linsys
  (system(value ?v&:(eq ?v Linux)))
	=>
	(bind ?*sys* 90)
	)


;;rules for peer to peer network metric
(deftemplate p2p (slot value))
(defglobal ?*p2p* = "0")
(defrule yesp2p
  (p2p (value ?v&: (eq ?v Yes)))
    =>
   (bind ?*p2p* 40)
    )

(defrule nop2p
  (p2p (value ?v&: (eq ?v No)))
    =>
   (bind ?*p2p* 100)
    )


;;rules for system architecture metric
(deftemplate sysarchitecture (slot value))
(defglobal ?*arch* = "0")
(defrule 64arch
  (sysarchitecture (value ?v&: (eq ?v 64)))
    =>
   (bind ?*arch* 100)
    )

(defrule 32arch
  (sysarchitecture (value ?v&: (eq ?v 32)))
    =>
   (bind ?*p2p* 80)
    )

;;rules for 3rd party app metric
(deftemplate thirdparty (slot value))
(defglobal ?*tp* = "0")

(defrule tplessthan5
      (thirdparty {value <= 5} )
    =>
    (bind ?*tp* 100)

   )

(defrule tplessthan20
      (thirdparty {value <= 20 && value > 5} )
    =>
    (bind ?*tp* 60)
    )

(defrule tplessthan50
      (thirdparty {value <= 50 && value > 20} )
    =>
    (bind ?*tp* 40)
    )

(defrule tplessthan100
      (thirdparty {value <= 100 && value > 50} )
    =>
    (bind ?*tp* 20)
    )
(defrule tpmorethan100
      (thirdparty {value > 100} )
    =>
    (bind ?*tp* 5)
    )

;;rule for security hierarchy
(deftemplate systemsecurity (slot value))
(defglobal ?*ss* = "0")
(defrule systemrating
?s <- (systemsecurity {value < 100} )
    =>
    (bind ?*ss* (* 3.33 ?s.value))
    )
;;rule for data hierarchy
(deftemplate datasecurity (slot value))
(defglobal ?*ds* = "0")
(defrule datarating
?d <- (datasecurity {value < 100} )
    =>
    (bind ?*ds* (* 3.34 ?d.value))
    )
;;rule for network hierarchy
(deftemplate networksecurity (slot value))
(defglobal ?*ns* = "0")
(defrule networkrating
?n <- (networksecurity {value < 100} )
    =>
    (bind ?*ns* (* 3.33 ?n.value))
    )

;;rule for calculating total security rating
(deftemplate totalsecurity (slot system) (slot data) (slot network))
(defglobal ?*t* = 0)
(defrule totalrating
?tr <- ( totalsecurity {system < 5})
	=> 
	(bind ?*t* (+ ( + ?tr.system ?tr.data) ?tr.network))
	)