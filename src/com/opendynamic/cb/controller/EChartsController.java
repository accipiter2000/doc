package com.opendynamic.cb.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;

@Controller
public class EChartsController extends OdController {
    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "barChart")
    public String barChart(Map<String, Object> operator) {
        return "cb/ECharts/barChart";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "pieChart")
    public String pieChart(Map<String, Object> operator) {
        return "cb/ECharts/pieChart";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "gaugeChart")
    public String gaugeChart(Map<String, Object> operator) {
        return "cb/ECharts/gaugeChart";
    }
}