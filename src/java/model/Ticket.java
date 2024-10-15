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
    private int Seat_Categoryid;
    private int Passenger_Typesid;
    private String code;
    private String pName;
    private int pSex;
    private String pPhoneNumber;
    private Date pDob;
    private int Baggagesid;
    private int Order_id;
    private int Statusid;

    public Ticket(int id, int Seat_Categoryid, int Passenger_Typesid, String code, String pName, int pSex, String pPhoneNumber, Date pDob, int Baggagesid, int Order_id, int Statusid) {
        this.id = id;
        this.Seat_Categoryid = Seat_Categoryid;
        this.Passenger_Typesid = Passenger_Typesid;
        this.code = code;
        this.pName = pName;
        this.pSex = pSex;
        this.pPhoneNumber = pPhoneNumber;
        this.pDob = pDob;
        this.Baggagesid = Baggagesid;
        this.Order_id = Order_id;
        this.Statusid = Statusid;
    }

    public Ticket(int Seat_Categoryid, int Passenger_Typesid, String code, String pName, int pSex, String pPhoneNumber, Date pDob, int Baggagesid, int Order_id, int Statusid) {
        this.Seat_Categoryid = Seat_Categoryid;
        this.Passenger_Typesid = Passenger_Typesid;
        this.code = code;
        this.pName = pName;
        this.pSex = pSex;
        this.pPhoneNumber = pPhoneNumber;
        this.pDob = pDob;
        this.Baggagesid = Baggagesid;
        this.Order_id = Order_id;
        this.Statusid = Statusid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSeat_Categoryid() {
        return Seat_Categoryid;
    }

    public void setSeat_Categoryid(int Seat_Categoryid) {
        this.Seat_Categoryid = Seat_Categoryid;
    }

    public int getPassenger_Typesid() {
        return Passenger_Typesid;
    }

    public void setPassenger_Typesid(int Passenger_Typesid) {
        this.Passenger_Typesid = Passenger_Typesid;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public int getBaggagesid() {
        return Baggagesid;
    }

    public void setBaggagesid(int Baggagesid) {
        this.Baggagesid = Baggagesid;
    }

    public int getOrder_id() {
        return Order_id;
    }

    public void setOrder_id(int Order_id) {
        this.Order_id = Order_id;
    }

    public int getStatusid() {
        return Statusid;
    }

    public void setStatusid(int Statusid) {
        this.Statusid = Statusid;
    }
}
