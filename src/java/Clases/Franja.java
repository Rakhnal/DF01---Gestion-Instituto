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
public class Franja {
    
    private int idFranja;
    private String frStart;
    private String frEnd;

    public Franja(int idFranja, String frStart, String frEnd) {
        this.idFranja = idFranja;
        this.frStart = frStart;
        this.frEnd = frEnd;
    }

    public int getIdFranja() {
        return idFranja;
    }

    public void setIdFranja(int idFranja) {
        this.idFranja = idFranja;
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
    
}
