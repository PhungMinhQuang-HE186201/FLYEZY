/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.time.LocalDate;


/**
 *
 * @author Admin
 */
public class ScheduledExecutorService {
    public static void main(String[] args) {
        java.util.concurrent.ScheduledExecutorService ses = Executors.newScheduledThreadPool(1);
        Runnable task = () -> {
            try {
                updateUnpaidTicket();
            } catch (Exception e) {
            }
        };
       
        ses.schedule(task, 1, TimeUnit.DAYS);
        ses.shutdown();
    }
    
    private static void updateUnpaidTicket(){
         LocalDate twoDaysLater = LocalDate.now().plusDays(2);
    }
}
