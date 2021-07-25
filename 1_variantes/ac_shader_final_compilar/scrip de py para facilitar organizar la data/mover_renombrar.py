


"""
script para facilidar mover y renombra elementos (para usar desde una IDE)

CUIDADO esto modifica todos los archivos continidos en una carpeta y les asigna un nuevo nombre y un formato .jpg,
no utilizar sin conocimientos sobre python y el sistema de archivos de su computadora

"""
import os
#import re 


carpeta = r"F:\Documentos\programacion\processing\sketchs\mae\proyectos mae\tiempo\ac_shader_final_compilar\data\img\c - copia"
direct =os.listdir(carpeta)

carpetaDestino = r"F:\Documentos\programacion\processing\sketchs\mae\proyectos mae\tiempo"
newPath =os.path.join(carpetaDestino,"new")
#newPath =os.path.join(carpeta,"new")

print(newPath)
os.mkdir(newPath)

for i in range(len(direct)):
    print(direct[i],"\n")
    actual =os.path.join(carpeta,direct[i]) 
    renombrado =os.path.join(newPath,str(i)+".jpg") 
    os.rename(actual,renombrado)

