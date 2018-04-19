package com.sis;

import com.sis.column.ClazzSearch;
import com.sis.common.Constants;
import com.sis.model.ClassDetail;
import com.sis.util.AnalysisUtil;
import com.sis.util.HttpClientUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Test {
    public static void main(String[] args) {
        String date = "2017-12-01";
        System.out.print(date.compareTo("31"));

        String url = Constants.ClazzSearchUrl;
        Map<String,String> param = new HashMap<>();
        param.put("siteId",Constants.SITE_ID);
        param.put("classNo","1810001");
        String clazzSearch = HttpClientUtil.sendHttpGet(url,param);
        List<ClazzSearch> search = AnalysisUtil.analyClazzSearch(clazzSearch);
        List<ClassDetail> details = AnalysisUtil.searchToDetail(search);
        System.out.println(search.size());

    }
}
