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
        (anterior ?x - libro ?y - libro)
        (paralelo ?x - libro ?y - libro)

        (leido ?x - libro ?y - mes)
        (leido ?x - libro)
        (quiere ?x - libro)
    )

    (:action leer
        :parameters (?l - libro ?m - mes ?lant - libro ?mant - mes)
        :precondition (and 

            (and 
                (anterior ?lant ?l)
                (or 
                    (leido ?lant)               ; O bine lo ha leido el usuario en el pasado
                    (and                        ; O bien hemos planificado su lectura en un mes anterior
                        (leido ?lant ?mant)
                        (anterior ?mant ?m)
                    )
                )
            )
            (and  ; AQUI QUIERO PONER LO DE LOS PARALELOS PERO NO ESTA HECHO
                (paralelo ?lant ?l)
                (or 
                    (leido ?lant)               ; O bine lo ha leido el usuario en el pasado
                    (and                        ; O bien hemos planificado su lectura en un mes anterior
                        (leido ?lant ?mant)
                        (anterior ?mant ?m)
                    )
                )
            )
            
            
        )
        :effect (and )
    )
    

)

