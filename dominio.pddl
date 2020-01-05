(define (domain books)

    (:requirements
        :strips
        :typing
        :adl
    )

    (:types
        libro mes - object
    )


    (:predicates
        
        (anterior ?x - mes ?y - mes)
        (anterior_directo ?x - mes ?y - mes)
        
        (predecesor ?x - libro ?y - libro)
        (paralelo ?x - libro ?y - libro)

        (lee ?x - libro ?y - mes)
        (leido ?x - libro)
    )

    
    ; Establecer mes de lectura a libros que tengan su predecesor establecido 
    (:action leer_con_anterior
        :parameters (?l - libro ?m - mes)
        :precondition (and 
            
            (not (leido ?l))

            (forall (?auxl - libro)
                (imply (predecesor ?auxl ?l) (and
                    (leido ?auxl)
                    (not (exists (?auxm - mes) (and (lee ?auxl ?auxm) (or (anterior ?m ?auxm) (= ?m ?auxm)))))
                ))
            )

        )
        :effect (and (leido ?l) (lee ?l ?m))
    )


    ;(:action leer_con_paralelo
    ;    :parameters (?l - libro ?m - mes ?lpar - libro ?mpar - mes ?lant - libro ?mant - mes)
    ;    :precondition (and

    ;        (not (leido ?l))
;
 ;           (predecesor ?lant ?l)
  ;          (leido ?lant)
   ;         (lee ?lant ?mant)
  ;          (anterior ?mant ?m)
;
 ;           (forall (?p - libro) (and
   ;             (paralelo ?l ?p)
    ;            (leido ?p)
     ;       ))

            

      ;  )
       ; :effect (and (and (leido ?l) (lee ?l ?m)))
    ;)
    

)

