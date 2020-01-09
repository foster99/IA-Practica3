(define (problem Book-Planner)
	(:domain books)
	(:objects a b c d e f g h - libro
              enero febrero marzo abril mayo junio julio agosto setiembre octubre noviembre diciembre - mes
    )
	(:init  
		(anterior enero febrero)(anterior enero marzo)(anterior enero abril)(anterior enero mayo)(anterior enero junio)(anterior enero julio)(anterior enero agosto)(anterior enero setiembre)(anterior enero octubre)(anterior enero noviembre)(anterior enero diciembre)(anterior febrero marzo)(anterior febrero abril)(anterior febrero mayo)(anterior febrero junio)(anterior febrero julio)(anterior febrero agosto)(anterior febrero setiembre)(anterior febrero octubre)(anterior febrero noviembre)(anterior febrero diciembre)(anterior marzo abril)(anterior marzo mayo)(anterior marzo junio)(anterior marzo julio)(anterior marzo agosto)(anterior marzo setiembre)(anterior marzo octubre)(anterior marzo noviembre)(anterior marzo diciembre)(anterior abril mayo)(anterior abril junio)(anterior abril julio)(anterior abril agosto)(anterior abril setiembre)(anterior abril octubre)(anterior abril noviembre)(anterior abril diciembre)(anterior mayo junio)(anterior mayo julio)(anterior mayo agosto)(anterior mayo setiembre)(anterior mayo octubre)(anterior mayo noviembre)(anterior mayo diciembre)(anterior junio julio)(anterior junio agosto)(anterior junio setiembre)(anterior junio octubre)(anterior junio noviembre)(anterior junio diciembre)(anterior julio agosto)(anterior julio setiembre)(anterior julio octubre)(anterior julio noviembre)(anterior julio diciembre)(anterior agosto setiembre)(anterior agosto octubre)(anterior agosto noviembre)(anterior agosto diciembre)(anterior setiembre octubre)(anterior setiembre noviembre)(anterior setiembre diciembre)(anterior octubre noviembre)(anterior octubre diciembre)(anterior noviembre diciembre)

		(dist01 enero enero)(dist01 enero febrero)(dist01 febrero enero)(dist01 febrero febrero)(dist01 febrero marzo)(dist01 marzo febrero)(dist01 marzo marzo)(dist01 marzo abril)(dist01 abril marzo)(dist01 abril abril)(dist01 abril mayo)(dist01 mayo abril)(dist01 mayo mayo)(dist01 mayo junio)(dist01 junio mayo)(dist01 junio junio)(dist01 junio julio)(dist01 julio junio)(dist01 julio julio)(dist01 julio agosto)(dist01 agosto julio)(dist01 agosto agosto)(dist01 agosto setiembre)(dist01 setiembre agosto)(dist01 setiembre setiembre)(dist01 setiembre octubre)(dist01 octubre setiembre)(dist01 octubre octubre)(dist01 octubre noviembre)(dist01 noviembre octubre)(dist01 noviembre noviembre)(dist01 noviembre diciembre)(dist01 diciembre noviembre)(dist01 diciembre diciembre)

		(predecesor a b)(predecesor b c)(predecesor c d)
		(predecesor e f)(predecesor f g)(predecesor g h)
		(paralelo d e)

	)
	(:goal
		(and
			(leido h)
			(end)
)	)	)

