/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.FastTest;

import java.util.ArrayList;
import java.util.Scanner;

/**
 *
 * @author Admin
 */
public class tester {

    public static void main(String[] args) throws Exception {
        ArrayList<Integer> listI = new ArrayList<>();
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter 1: ");
        int a = sc.nextInt();
        for (Integer integer : listI) {
            if(integer == a){
                listI.remove(integer);
                break;
            }
        }
        listI.add(a);
        System.out.print("Enter 2: ");
        int b = sc.nextInt();
        for (Integer integer : listI) {
            if(integer == b){
                listI.remove(integer);
                break;
            }
        }
        listI.add(b);
        System.out.print("Enter 3: ");
        int c = sc.nextInt();
        for (Integer integer : listI) {
            if(integer == c){
                listI.remove(integer);
                break;
            }
        }
        listI.add(c);
        
        for (Integer integer : listI) {
            System.out.println(integer);
        }
    }
}
