package com.ytrue.mall.quartz.task;

import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.stereotype.Component;


@Component("orderTask")
public class OrderTask {


    public void cancelOrder() {
        System.out.println("我是OrderTask--cancelOrder：取消订单---我被触发了");
    }

    /**
     * 确认收货
     */
    public void confirmOrder() {
        System.out.println("我是OrderTask--confirmOrder：确认收货---我被触发了");
    }


    /**
     * 测试方法
     */
    public void test() {
        System.out.println("我是OrderTask--test：测试方法---我被触发了");
    }

}
