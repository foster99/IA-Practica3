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

        (leido ?x - libro ?y - mes)
        (leido ?x - libro)
        (quiere ?x - libro)
    )

    ; Marcar todos los libros "necesarios a leer" como libros que el usuario quiere leer.
    (:action anadir_a_lista_de_lectura
        :parameters (?l - libro ?aux - libro)
        :precondition (and 
            (quiere ?l)
            (not (quiere ?aux))
            (not (leido ?aux))
            (or 
                (predecesor ?aux ?l)
                (paralelo ?aux ?l)
            )
        )
        :effect (and (quiere ?aux))
    )
    
    ; Assignar un libro como "leido" en el caso de tener un predecesor
    (:action leer_con_anterior
        :parameters (?l - libro ?m - mes ?lant - libro ?mant - mes)
        :precondition (and 
            (quiere ?l)
            (not (leido ?l))
            (predecesor ?lant ?l)

            (not (paralelo ?l))

            (leido ?lant)           
            (leido ?lant ?mant)
            (anterior ?mant ?m)
        )
        :effect (and (leido ?l) (leido ?l ?m))
    )


    (:action leer_con_paralelo
        :parameters (?l - libro ?m - mes ?lpar - libro ?mpar - mes ?lant - libro ?mant - mes)
        :precondition (and

            (quiere ?l)
            (not (leido ?l))
            (paralelo ?lpar ?l)
            (leido ?lpar)
            (leido ?lpar ?mpar)
            (anterior_directo ?m ?y)
            
            (or 
                (leido ?lant)               ; O bien lo ha leido el usuario en el pasado
                (and                        ; O bien hemos planificado su lectura en un mes anterior
                    (leido ?lant ?mant)
                    (anterior ?mant ?m)
                )
            )
        )
        :effect (and )
    )
    

)

