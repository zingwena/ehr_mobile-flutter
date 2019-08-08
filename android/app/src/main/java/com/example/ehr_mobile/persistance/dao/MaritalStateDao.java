package com.example.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import com.example.ehr_mobile.model.MaritalStatus;

import java.util.List;

@Dao
public interface MaritalStateDao {

    @Insert
    void insertMaritalStates(List<MaritalStatus> maritalStatuses);

    @Insert
    void insertMAritalState(MaritalStatus maritalStatus);

    @Query("SELECT * FROM MaritalStatus")
    List<MaritalStatus> getAllMaritalStates();

    @Query("SELECT * FROM MaritalStatus WHERE id=:id")
    MaritalStatus findMaritalStateById(int id);
}
