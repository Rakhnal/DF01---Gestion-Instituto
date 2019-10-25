/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilidades;

import Clases.Reserva;
import java.util.ArrayList;

/**
 *
 * @author alvaro
 */
public class Auxiliar {
    
    public static boolean isReserved (ArrayList<Reserva> reservas, int idFranja) {
        
        boolean res = false;
        
        for (int i = 0; i < reservas.size() && !res; i++) {
            if (reservas.get(i).getIdFranja() == idFranja) res = true;
            
        }
        
        return res;
    }
    
}
