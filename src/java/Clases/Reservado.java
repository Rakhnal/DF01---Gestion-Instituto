/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

/**
 *
 * @author alvaro
 */
public class Reservado {
    private String fecha;
    private int idFranja;
    private String frStart;
    private String frEnd;
    private int idAula;
    private String descripcion;

    public Reservado(String fecha, int idFranja, String frStart, String frEnd, int idAula, String descripcion) {
        this.fecha = fecha;
        this.idFranja = idFranja;
        this.frStart = frStart;
        this.frEnd = frEnd;
        this.idAula = idAula;
        this.descripcion = descripcion;
    }

    public int getIdFranja() {
        return idFranja;
    }

    public void setIdFranja(int idFranja) {
        this.idFranja = idFranja;
    }
    
    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getFrStart() {
        return frStart;
    }

    public void setFrStart(String frStart) {
        this.frStart = frStart;
    }

    public String getFrEnd() {
        return frEnd;
    }

    public void setFrEnd(String frEnd) {
        this.frEnd = frEnd;
    }

    public int getIdAula() {
        return idAula;
    }

    public void setIdAula(int idAula) {
        this.idAula = idAula;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
