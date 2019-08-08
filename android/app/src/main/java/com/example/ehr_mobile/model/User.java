package com.example.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import java.util.List;


@Entity
public class User extends PersonBaseEntity {

    @PrimaryKey(autoGenerate = true)
    private int userId;

    @Ignore
    private List<String> authorities;


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<String> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(List<String> authorities) {
        this.authorities = authorities;
    }

    @Override
    public String toString() {
        return super.toString() + "User{" +//call this to string after base to String has been called
                "userId=" + userId +
                ", authorities=" + authorities +
                '}';
    }

    //    public  String strSeparator = "__,__";

//     public String convertArrayToList(ArrayList arrayList){
//         String permissions="";
//         for(int i=0;i<arrayList.size();i++){
//             permissions= permissions+arrayList.get(i);
//
//             if(i<arrayList.size()-1){
//                 permissions = permissions+strSeparator;
//             }
//
//         }
//         return permissions;
//     }


}
