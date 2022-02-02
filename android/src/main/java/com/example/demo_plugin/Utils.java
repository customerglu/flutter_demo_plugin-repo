package com.example.demo_plugin;

import android.util.Log;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class Utils {

    @SuppressWarnings("ConstantConditions")
    static HashMap<String, Object> dartMapToProfileMap(Map<String, Object> profileMap) {
        if (profileMap == null) {
            return null;
        }

        HashMap<String, Object> profile = new HashMap<>();
        for (Map.Entry<String, Object> stringObjectEntry : profileMap.entrySet()) {
            try {
                String key = stringObjectEntry.getKey();

//                if ("DOB".equals(key)) {
//                    String dob = profileMap.get(key).toString();
//                    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
//                    Date date = format.parse(dob);
//                    profile.put(key, date);
//                } else {
                    profile.put(key, stringObjectEntry.getValue());
         //       }
            } catch (Throwable t) {
                Log.e("CleverTapError", t.getMessage());
            }
        }
        return profile;
    }
}
