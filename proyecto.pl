enfermedad(influenza, [escurrimiento_nasal, dolor_articulaciones, dolor_muscular, postracion, diarrea]).
enfermedad(resfriado, [rinorrea, secrecion_nasal, congestion_nasal, estornudos, dolor_garganta, dolor_cabeza]).
enfermedad(tuberculosis, [tos_cronica, dolor_pecho, tos_sangre, tos_esputo, debilidad, perdida_peso, falta_apetito, escalofrios, fiebre, sudores_nocturnos]).
enfermedad(neumonia, [dolor_pecho, desorientacion, tos_flema, fatiga, fiebre, escalofrios, nauseas, vomito, diarrea, dificultad_respirar]).
enfermedad(varicela, [sarpullido, fiebre, cansancio, falta_apetito, dolor_cabeza]).
enfermedad(malaria, [fiebre, escalofrios, dolor_cabeza, nauseas, vomito, diarrea, dolor_abdominal, tos, frecuencia_cardiaca_acelerada]).
enfermedad(sarampion, [fiebre, tos_seca, escurrimiento_nasal, dolor_garganta, ojos_inflamados, manchas_koplik, sarpullido]).
enfermedad(fiebre_maculosa, [fiebre, dolor_cabeza, sarpullido, nauseas, vomito, dolor_estomago, dolor_muscular, falta_apetito]).
enfermedad(herpes, [comezon, protuberancias_rojas, ampollas_blancas, ulceras, costras]).
enfermedad(tetanos, [espasmos_musculares, tension_musculos_labios, rigidez_musculos_cuello, rigidez_musculos_abdomen]).
enfermedad(polio, [fiebre, dolor_garganta, dolor_cabeza, vomito, fatiga, rigidez_musculos_espalda, rigidez_musculos_cuello, rigidez_musculos_brazos, rigidez_musculos_piernas, perdida_reflejos, extremidades_flojas, problemas_respiracion, apnea_suenio]).
enfermedad(salmonela, [diarrea, colicos_estomacales, fiebre, nauseas, vomito, escalofrios, dolor_cabeza, sangre_heces]).

:- dynamic enfermedad/2.
:- dynamic sintomas/1.
:- dynamic count/1.

sintomas([]).
count([_, []]).

existe_en_lista(X,Y):- member(Y,X), !.
existe_en_enfermedad([Cabeza_sintoma|Cola_sintoma], A, B, C):- (member(Cabeza_sintoma, B) -> (C == 0 -> Z is 1 ; Z is C+1) ; Z is 0), existe_en_enfermedad(Cola_sintoma, A, B, Z).

test([Cabeza_sintoma|Cola_sintoma],A,B,C):- longitud([Cabeza_sintoma|Cola_sintoma], N), (member(Cabeza_sintoma, B) -> C1 is C+1 ; C1 is C), (N =:= 1 -> (asserta(count([[A], [C1]]))) ; (true)), test(Cola_sintoma,A,B,C1).
insertar([],X,[X]).
insertar([H|T], N, [H|R]):- insertar(T, N, R).
imprimir([Head|Tail]):- write_ln(Head), imprimir(Tail);!. 

longitud([],0).
longitud([_|T],N):- longitud(T,N1), N is N1+1.
limpiar_lista([], []).
limpiar_lista([Cabeza|Cola], Resultado):- member(Cabeza, Cola), !, limpiar_lista(Cola, Resultado).
limpiar_lista([Cabeza|Cola], [Cabeza|Resultado]):- limpiar_lista(Cola, Resultado).

vaciar_lista:- retractall(sintomas(_)), asserta(sintomas([])), retractall(count(_)), asserta(count(0)).

preguntar:- write("Ingrese el sintoma: "), read(Y), escribir(Y).
escribir(Y):- sintomas(X), (not(existe_en_lista(X,Y)) -> (insertar(X, Y, New), retractall(sintomas(_)), asserta(sintomas(New)), write_ln("Desea agregar otro sintoma? [s/n]: "), read(Z), (Z == s -> preguntar ; true)) ; (write_ln("El sintoma ingresado ya se encuentra registrado, intente de nuevo."), preguntar)).

mostrar_sintomas(X):- write_ln(""), write_ln("Los sintomas ingresados son: "), imprimir(X).

inicio:- vaciar_lista, preguntar, sintomas(Y), mostrar_sintomas(Y), enfermedad(A,B), C is 0, test(Y,A,B,C).
