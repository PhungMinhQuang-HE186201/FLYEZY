/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.sql.Date;
/**
 *
 * @author Fantasy
 */
public class Ticket {
    private int id;
    private int Flight_Detailid;
    private int Seat_Categoryid;
    private String name;
    private String pName;
    private int pSex;
    private String pPhoneNumber;
    private Date pDob;
    private Timestamp paymentTime;
    private int PaymentTypeid;
    private int Accountsid;
    private int Passenger_Typesid;
    private int Baggagesid;
    private int Statusid;
    private int Flight_Type_id;

    public Ticket(int id, int Flight_Detailid, int Seat_Categoryid, String name, String pName, int pSex, String pPhoneNumber, Date pDob, Timestamp paymentTime, int PaymentTypeid, int Accountsid, int Passenger_Typesid, int Baggagesid, int Statusid, int Flight_Typeid) {
        this.id = id;
        this.Flight_Detailid = Flight_Detailid;
        this.Seat_Categoryid = Seat_Categoryid;
        this.name = name;
        this.pName = pName;
        this.pSex = pSex;
        this.pPhoneNumber = pPhoneNumber;
        this.pDob = pDob;
        this.paymentTime = paymentTime;
        this.PaymentTypeid = PaymentTypeid;
        this.Accountsid = Accountsid;
        this.Passenger_Typesid = Passenger_Typesid;
        this.Baggagesid = Baggagesid;
        this.Statusid = Statusid;
        this.Flight_Type_id = Flight_Typeid;
    }

    public Ticket(int Flight_Detailid, int Seat_Categoryid, String name, String pName, int pSex, String pPhoneNumber, Date pDob, Timestamp paymentTime, int PaymentTypeid, int Accountsid, int Passenger_Typesid, int Baggagesid, int Statusid, int Flight_Typeid) {
        this.Flight_Detailid = Flight_Detailid;
        this.Seat_Categoryid = Seat_Categoryid;
        this.name = name;
        this.pName = pName;
        this.pSex = pSex;
        this.pPhoneNumber = pPhoneNumber;
        this.pDob = pDob;
        this.paymentTime = paymentTime;
        this.PaymentTypeid = PaymentTypeid;
        this.Accountsid = Accountsid;
        this.Passenger_Typesid = Passenger_Typesid;
        this.Baggagesid = Baggagesid;
        this.Statusid = Statusid;
        this.Flight_Type_id = Flight_Typeid;
    }

    public int getPaymentTypeid() {
        return PaymentTypeid;
    }

    public void setPaymentTypeid(int PaymentTypeid) {
        this.PaymentTypeid = PaymentTypeid;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFlight_Detailid() {
        return Flight_Detailid;
    }

    public void setFlight_Detailid(int Flight_Detailid) {
        this.Flight_Detailid = Flight_Detailid;
    }

    public int getSeat_Categoryid() {
        return Seat_Categoryid;
    }

    public void setSeat_Categoryid(int Seat_Categoryid) {
        this.Seat_Categoryid = Seat_Categoryid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public int getpSex() {
        return pSex;
    }

    public void setpSex(int pSex) {
        this.pSex = pSex;
    }

    public String getpPhoneNumber() {
        return pPhoneNumber;
    }

    public void setpPhoneNumber(String pPhoneNumber) {
        this.pPhoneNumber = pPhoneNumber;
    }

    public Date getpDob() {
        return pDob;
    }

    public void setpDob(Date pDob) {
        this.pDob = pDob;
    }

    public Timestamp getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Timestamp paymentTime) {
        this.paymentTime = paymentTime;
    }

    public int getAccountsid() {
        return Accountsid;
    }

    public void setAccountsid(int Accountsid) {
        this.Accountsid = Accountsid;
    }

    public int getPassenger_Typesid() {
        return Passenger_Typesid;
    }

    public void setPassenger_Typesid(int Passenger_Typesid) {
        this.Passenger_Typesid = Passenger_Typesid;
    }

    public int getBaggagesid() {
        return Baggagesid;
    }

    public void setBaggagesid(int Baggagesid) {
        this.Baggagesid = Baggagesid;
    }

    public int getStatusid() {
        return Statusid;
    }

    public void setStatusid(int Statusid) {
        this.Statusid = Statusid;
    }

    public int getFlight_Typeid() {
        return Flight_Type_id;
    }

    public void setFlight_Typeid(int Flight_Typeid) {
        this.Flight_Type_id = Flight_Typeid;
    }
    
    
        
}
