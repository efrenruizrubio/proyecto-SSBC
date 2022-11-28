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
count([0]).

existe_en_sintomas(X):- sintomas(Y), member(X,Y), !.
existe_en_enfermedad([Cabeza_sintoma|Cola_sintoma]):- enfermedad(A,B), imprimir(B). 

insertar([],X,[X]).
insertar([H|T], N, [H|R]):- insertar(T, N, R).
imprimir([Head|Tail]):- write_ln(Head), imprimir(Tail);!. 
lista_esta_vacia(L):- not(existe_en_sintomas(_,L)).
vaciar_lista:- retractall(sintomas(_)), asserta(sintomas([])), retractall(count(_)), asserta(count(0)).

preguntar:- write('Ingrese el sintoma: '), read(X), escribir(X), write_ln("Desea ingresar otro sintoma? [s/n]"), read(Y), (Y == s -> preguntar ;  true).
escribir(Y):- sintomas(X), not(existe_en_sintomas(Y)), insertar(X, Y, New), retractall(sintomas(_)), asserta(sintomas(New)), !.
escribir(_):- write_ln("Los sintomas no se registraron debido a que se ingreso un sintoma o mas repetido, intente de nuevo."), preguntar.

mostrar_sintomas(X):- write_ln(""), write_ln("Los sintomas ingresados son: "), imprimir(X).

inicio:- vaciar_lista, preguntar, sintomas(Y), mostrar_sintomas(Y), existe_en_enfermedad(Y).
