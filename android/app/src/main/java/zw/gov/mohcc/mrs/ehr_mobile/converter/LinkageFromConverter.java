package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.LinkageFrom;

public class LinkageFromConverter {

    @TypeConverter
    public static LinkageFrom toLinkageFrom(String linkageFrom) {

        if (linkageFrom.equals(LinkageFrom.EID.getLinkageFrom())) {
            return LinkageFrom.EID;
        } else if (linkageFrom.equals(LinkageFrom.HTS.getLinkageFrom())) {
            return LinkageFrom.HTS;
        } else if (linkageFrom.equals(LinkageFrom.PMTCT.getLinkageFrom())) {
            return LinkageFrom.PMTCT;
        } else if (linkageFrom.equals(LinkageFrom.PMTCT.getLinkageFrom())) {
            return LinkageFrom.PMTCT;
        } else if (linkageFrom.equals(LinkageFrom.STI.getLinkageFrom())) {
            return LinkageFrom.STI;
        } else if (linkageFrom.equals(LinkageFrom.TB_PROGRAM.getLinkageFrom())) {
            return LinkageFrom.TB_PROGRAM;
        } else if (linkageFrom.equals(LinkageFrom.VMMC.getLinkageFrom())) {
            return LinkageFrom.VMMC;
        } else if (linkageFrom.equals(LinkageFrom.VIAC.getLinkageFrom())) {
            return LinkageFrom.VIAC;
        }
        return null;
    }

    @TypeConverter
    public static String toString(LinkageFrom linkageFrom) {
        if (linkageFrom == null) {
            return null;
        }
        return linkageFrom.getLinkageFrom();
    }
}
