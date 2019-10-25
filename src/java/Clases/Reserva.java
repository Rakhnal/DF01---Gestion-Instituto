/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.sql.Date;

/**
 *
 * @author alvaro
 */
public class Reserva {
    
    private String dni;
    private int idAula;
    private int idFranja;
    private Date fecha;

    public Reserva(String dni, int idAula, int idFranja, java.sql.Date fecha) {
        this.dni = dni;
        this.idAula = idAula;
        this.idFranja = idFranja;
        this.fecha = fecha;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public int getIdAula() {
        return idAula;
    }

    public void setIdAula(int idAula) {
        this.idAula = idAula;
    }

    public int getIdFranja() {
        return idFranja;
    }

    public void setIdFranja(int idFranja) {
        this.idFranja = idFranja;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
}
