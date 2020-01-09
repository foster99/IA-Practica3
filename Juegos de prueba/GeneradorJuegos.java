import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class GeneradorJuegos {

   private static void writeFile(boolean[] libros, ArrayList<String> predecesores, ArrayList<String> paralelos, ArrayList<String> leidos, ArrayList<String> goal) {
        try {
            FileOutputStream fos = new FileOutputStream("./problema.pddl");
            DataOutputStream dos = new DataOutputStream(fos);
            dos.writeBytes("(define (problem Book-Planner)\n" +
                    "\t(:domain books)\n" +
                    "\t(:objects ");
            String s = "";
            for (int i = 0; i < libros.length; i++) {
                s += (""+(char)(i+97)+" ");
            }
            dos.writeBytes(s+ "- libro\n");
            dos.writeBytes("              enero febrero marzo abril mayo junio julio agosto setiembre octubre noviembre diciembre - mes\n" +
                    "    )\n");
            dos.writeBytes("\t(:init  \n" +
                              "\t\t(anterior enero febrero)(anterior enero marzo)(anterior enero abril)(anterior enero mayo)(anterior enero junio)(anterior enero julio)(anterior enero agosto)(anterior enero setiembre)(anterior enero octubre)(anterior enero noviembre)(anterior enero diciembre)(anterior febrero marzo)(anterior febrero abril)(anterior febrero mayo)(anterior febrero junio)(anterior febrero julio)(anterior febrero agosto)(anterior febrero setiembre)(anterior febrero octubre)(anterior febrero noviembre)(anterior febrero diciembre)(anterior marzo abril)(anterior marzo mayo)(anterior marzo junio)(anterior marzo julio)(anterior marzo agosto)(anterior marzo setiembre)(anterior marzo octubre)(anterior marzo noviembre)(anterior marzo diciembre)(anterior abril mayo)(anterior abril junio)(anterior abril julio)(anterior abril agosto)(anterior abril setiembre)(anterior abril octubre)(anterior abril noviembre)(anterior abril diciembre)(anterior mayo junio)(anterior mayo julio)(anterior mayo agosto)(anterior mayo setiembre)(anterior mayo octubre)(anterior mayo noviembre)(anterior mayo diciembre)(anterior junio julio)(anterior junio agosto)(anterior junio setiembre)(anterior junio octubre)(anterior junio noviembre)(anterior junio diciembre)(anterior julio agosto)(anterior julio setiembre)(anterior julio octubre)(anterior julio noviembre)(anterior julio diciembre)(anterior agosto setiembre)(anterior agosto octubre)(anterior agosto noviembre)(anterior agosto diciembre)(anterior setiembre octubre)(anterior setiembre noviembre)(anterior setiembre diciembre)(anterior octubre noviembre)(anterior octubre diciembre)(anterior noviembre diciembre)\n" +
                              "\n" +
                              "\t\t(dist01 enero enero)(dist01 enero febrero)(dist01 febrero enero)(dist01 febrero febrero)(dist01 febrero marzo)(dist01 marzo febrero)(dist01 marzo marzo)(dist01 marzo abril)(dist01 abril marzo)(dist01 abril abril)(dist01 abril mayo)(dist01 mayo abril)(dist01 mayo mayo)(dist01 mayo junio)(dist01 junio mayo)(dist01 junio junio)(dist01 junio julio)(dist01 julio junio)(dist01 julio julio)(dist01 julio agosto)(dist01 agosto julio)(dist01 agosto agosto)(dist01 agosto setiembre)(dist01 setiembre agosto)(dist01 setiembre setiembre)(dist01 setiembre octubre)(dist01 octubre setiembre)(dist01 octubre octubre)(dist01 octubre noviembre)(dist01 noviembre octubre)(dist01 noviembre noviembre)(dist01 noviembre diciembre)(dist01 diciembre noviembre)(dist01 diciembre diciembre)\n"+
                              "\n\t\t");


            for (int i = 0; i < predecesores.size(); i++) {
                dos.writeBytes(predecesores.get(i));
            }
            dos.writeBytes("\n\t\t");
            for (int i = 0; i < paralelos.size(); i++) {
                dos.writeBytes(paralelos.get(i));
            }
            dos.writeBytes("\n\t\t");
            for (int i = 0; i < leidos.size(); i++) {
                dos.writeBytes(leidos.get(i));
            }
            dos.writeBytes("\n\t)\n");
            dos.writeBytes("\t(:goal\n" +
                              "\t\t(and\n\t\t\t");
            for (int i = 0; i < goal.size(); i++) {
                dos.writeBytes(goal.get(i));
            }
            dos.writeBytes("\n\t\t\t(end)\n\t\t)\n\t)\n)");
            fos.close();
            dos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static ArrayList<String> generarLeidos(int n, String frase) {
        Scanner in = new Scanner(System.in);
        System.out.println(frase+"Los libros deben estar entre [a.."+(char) (n + 97)+"] (Para seleccionar todos, escriba 'all')");
        String s = in.nextLine();
        if (s.equals("all")) {
            s = "a";
            for (int i = 1; i < n+1; i++) {
                s +=  " "+(char)(i + 97);
            }
        }
        String[] libs = s.split(" ");
        ArrayList<String> leidos = new ArrayList<>();
        for (String libro : libs) {
            if (!libro.equals("")) leidos.add("(leido " + libro + ")");
        }
        System.out.println("LIBROS TIPO leido: ");
        for (String leido : leidos) {
            System.out.println(leido);
        }
        return leidos;
    }

    private static ArrayList<String> generarRelaciones(String relacion, boolean[] libros) {
        Scanner in = new Scanner(System.in);
        if (relacion.equals("paralelo")) System.out.println("Introduzca la probabilidad de que un libro sea predecesor de otro [0..1]:");
        else if (relacion.equals("predecesor")) System.out.println("Introduzca la probabilidad de que un libro sea paralelo a otro [0..1]:");
        double p;
        while (true) {
            p = in.nextDouble();
            if (p <= 1 && p >= 0) break;
            else System.out.println("ERROR: Número no pertenece a [0..0,5]");
        }

        ArrayList<String> relacionados = new ArrayList<>();
        for (int i = 0; i < libros.length; i++) {
            double rand = Math.random();
            if (rand < p && p != 0) {
                int libro = (int) (Math.random() * 100) % libros.length + 1;
                String rel = "(" + relacion + " " + (char) (i + 97) + " " + (char) (libro-1+97) + ")";
                if (libro-1 > i) relacionados.add(rel);//para evitar ciclos
            }
        }
        System.out.println("LIBROS TIPO "+relacion+": ");
        for (String relacionado : relacionados) {
            System.out.println(relacionado);
        }
        return relacionados;
    }

    private static boolean[] generarLibros() {

        Scanner in = new Scanner(System.in);
        System.out.println("Introduzca el número de libros [1..26]:");
        int n = 0;
        while (true) {
            n = in.nextInt();
            if (n < 27 && n > 0) break;
            else System.out.println("ERROR: Número no pertenece a [1..26]");
        }
        boolean[]libros  = new boolean[n];
        System.out.println("Libros: ");
        System.out.print(""+(char)(97));
        for (int i = 1; i < libros.length; i++) {
            System.out.print(", "+(char)(i+97));
        }
        System.out.print("\n");
        return libros;
    }

    public static void main(String[] args) {
        System.out.println("---GENERADOR DE JUEGOS DE PRUEBA---\n");
        boolean[] libros = generarLibros();
        ArrayList<String> predecesores = generarRelaciones("predecesor", libros);
        ArrayList<String> paralelos = generarRelaciones("paralelo", libros);
        ArrayList<String> leidos = generarLeidos(libros.length-1, "Introduzca los libros que se ha leído. ");
        ArrayList<String> goal = generarLeidos(libros.length-1, "Introduzca los libros que quiere leer. ");
        writeFile(libros, predecesores, paralelos, leidos, goal);
    }
}
