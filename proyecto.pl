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
:- dynamic cont/1.
:- dynamic sintomas/1.
:- dynamic count/1.

sintomas([]).
count(0).

existe_en_sintomas(X):- sintomas(Y), member(X,Y), !.
test:- enfermedad(A,B,_), count(X), V is X+1, assert(count(V)), retractall(enfermedad(_,_,_)), assert(enfermedad(A,B,V)).
existe_en_enfermedad([Cabeza_sintoma|Cola_sintoma], X):- member(Cabeza_sintoma, X) ; existe_en_enfermedad(Cola_sintoma, X). 

insertar([],X,[X]).
insertar([H|T], N, [H|R]):- insertar(T, N, R).
escribir(Y):- sintomas(X), not(existe_en_sintomas(Y)), insertar(X, Y, New), retractall(sintomas(_)), asserta(sintomas(New)), !.
escribir(_):- retractall(sintomas(_)), write_ln("Los sintomas no se registraron debido a que se ingreso un sintoma o mas repetido, intente de nuevo.").
imprimir([Head|Tail]):- write_ln(Head), imprimir(Tail);!. 
lista_esta_vacia(L):- not(existe_en_sintomas(_,L)).
vaciar_lista:- retractall(sintomas(_)), asserta(sintomas([])).

numero_sintomas:- retractall(cont(_)), write("Ingrese el numero de sintomas que desea ingresar: "), read(X), asserta(cont(X)), vaciar_lista.

preguntar(0):- write_ln(""), write_ln("Los sintomas ingresados son: "), sintomas(X), imprimir(X).
preguntar(X):- X > 0, write('Ingrese el sintoma: '), read(Y), escribir(Y), S is X-1, preguntar(S).

inicio:- numero_sintomas, cont(X), preguntar(X), sintomas(Y), enfermedad(_, B), existe_en_enfermedad(Y, B).
