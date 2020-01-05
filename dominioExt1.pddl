(define (domain books)

    (:requirements
        :strips
        :typing
        :equality
        :adl
    )

    (:types
        libro mes - object
    )


    (:predicates
        
        (anterior ?x - mes ?y - mes)               ; Expresa que el mex X es estrictamente anterior al mes Y.
        (predecesor ?x - libro ?y - libro)      ; Expresa que el libro X es predecesor del libro Y.
        (leido ?x - libro)                      ; Expresa que un libro ya esta leido (o introducido en el plan).
        (last_pre ?x - libro ?y - mes)          ; Expresa que el libro X debe ser leido en un mes estrictamente posterior a Y.

    )

    ; Elimina el statement de predecesor de aquellos libros que ya se han leido
    ; Esta accion solo es ejecutada para los libros que el usuario ya se ha leido previamente (libros fuera del plan).
    (:action delete_pre
        :parameters (?l - libro)
        :precondition (leido ?l)
        :effect (forall (?p - libro) (when (predecesor ?l ?p) (not (predecesor ?l ?p))))
    )

    
    ; Accion que corresponde a leer un libro en un mes concreto.
    ; Solo se lee el libro todos los predecesores se han leido en un mes anterior al targeteado por la accion.
    (:action leer
        :parameters (?l - libro ?m - mes)
        :precondition (and 
            (not (leido ?l))                                                ; Libro targeteado no leido.
            (not (exists (?p - libro) (predecesor ?p ?l)))                  ; No hay predecesores sin leer (los leidos borran el statement de predecesor).
            (forall (?t - mes) (imply (last_pre ?l ?t) (anterior ?t ?m)))   ; El mes targeteado es anterior a al de todos los predecesores leidos (han creado del statement last_pre).
        )
        :effect (and
            (leido ?l)                                                      ; Marcamos el libro como leido.
            (forall (?p - libro)  (when (predecesor ?l ?p)                  ; Para todos los libros de los que el libro es predecesor.
                (and
                    (not (predecesor ?l ?p))                                ; Borramos el statement de ser predecesor.
                    (last_pre ?p ?m)                                        ; Establecemos el mes al que deben ser sus sucesores estrictamente posteriores.
                )
            ))
        )
    )
)

