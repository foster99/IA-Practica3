(define (domain books)

    (:requirements
        :strips
        :typing
        :equality
        :adl
        :fluents
    )

    (:functions
        (sumaPag ?m - mes ?l - libro)
    )

    (:metric minimize 
        (forall () (sumaPag ?m ?l)
    )

    (:types
        libro mes - object
    )


    (:predicates
        
        ; PREDECESORES
        (anterior ?x - mes ?y - mes)                    ; Expresa que el mex X es estrictamente anterior al mes Y.
        (predecesor ?x - libro ?y - libro)      ; Expresa que el libro X es predecesor del libro Y.
        (predecesor_pendiente ?x - libro ?y - mes)     ; Expresa que el libro X debe ser leido en un mes estrictamente posterior a Y.
        
        ; PARALELOS
        (dist01 ?x - mes ?y - mes)                      ; Expresa que el mex X esta a distancia (0,1) de Y.
        (paralelo ?x - libro ?y - libro)              ; Expresa que el libro X es paralelo al libro Y
        (paralelos_pendientes ?x - libro ?y - mes)    ; Expresa que el libro X debe ser leido en un mes a distancia (0,1) de Y.

        ; CONTROL
        (leido ?x - libro)                              ; Expresa que un libro ya esta leido (o introducido en el plan).
        (end)                                          ; Predicado que marca el fin del proceso (utilizado para comprobar antes de acabar que todo libro paralelo este insertado)
    )


    ; Accion que elimina todas las restricciones de predecesor y paralelo que tienen los libros ya leidos, dado que estas no interferiran en el plan
    ; Esta accion solo es ejecutada para los libros que el usuario ya se ha leido previamente (libros fuera del plan).
    (:action set_leido
        :parameters (?l - libro)
        :precondition (and (leido ?l) (not (end)))
        :effect (and
            (forall (?p - libro) (when (predecesor ?l ?p) (not (predecesor ?l ?p))))
            (forall (?p - libro) (when (paralelo ?l ?p) (and (not (paralelo ?l ?p))(not (paralelo ?p ?l)))))
        )
    )


    ; Accion que controla que la planificacion acabe solo cuando se hayan introducido todos los paralelos pendientes.
    (:action end
        :parameters ()
        :precondition (not (exists (?p - libro ?m - mes) (paralelos_pendientes ?p ?m)))
        :effect (end)
    )


    ; Accion que corresponde a leer un libro en un mes concreto.
    ; Solo se lee el libro todos los predecesores se han leido en un mes anterior al targeteado por la accion.
    (:action leer
        :parameters (?l - libro ?m - mes)
        :precondition (and 

            (not (end))                                                 ; El programa no ha acabado.
            (not (leido ?l))                                            ; Libro targeteado no leido.
            (not (exists (?p - libro) (predecesor ?p ?l)))              ; No hay predecesores sin leer.
            (not (exists (?p - libro) (paralelo ?p ?l)))                ; No hay libros paralelos a mi (en este sentido) sin leer.


            (forall (?t - mes) (and                                     ; Comprobacion de fechas
                (imply (predecesor_pendiente ?l ?t) (anterior ?t ?m))   ; El mes es anterior a al de todos los predecesores leidos.
                (imply (paralelos_pendientes ?l ?t) (dist01 ?t ?m))     ; El mes esta a distancia (0,1) de todos los libros que han declarado al sujeto como paralelo.
            ))   
            
        )
        :effect (and

            (leido ?l)                                                  ; Marcamos el libro como leido.

            (forall (?mm - mes) (not (paralelos_pendientes ?l ?mm)))    ; Eliminamos el libro sujeto de la 'lista' de paralelos pendientes.

            (forall (?p - libro)
                (when (predecesor ?l ?p) (and                           
                    (not (predecesor ?l ?p))                            ; Borramos la restriccion de ser predecesor (ya que este esta leido, y ya no afectara).
                    (predecesor_pendiente ?p ?m)                        ; Establecemos el mes al que sus sucesores deben ser estrictamente posteriores.
                ))
            )
            
            (forall (?p - libro)
                (when (paralelo ?l ?p) (and
                    (not (paralelo ?l ?p))                              ; Borramos la restriccion de ser paralelo (ya que este esta leido, y ya no afectara).
                    (paralelos_pendientes ?p ?m)                        ; Establecemos el mes al que sus paralelos deben estar a distancia 0 o 1.                   
                ))
            )
        )
    )
)

