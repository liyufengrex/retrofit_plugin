package com.rex.retrofit_plugin.net.base;

import java.util.HashMap;
import retrofit2.Retrofit;

public final class RetrofitTool {

    private static HashMap<String, Retrofit> mRetrofits = new HashMap();

    private RetrofitTool() {
    }

    public static RetrofitTool getInstance() {
        return InnerHolder.mtNetWork;
    }

    // 创建retrofit
    public Retrofit getDefault(String baseUrl) {
        if (mRetrofits.get(baseUrl) == null) {
            mRetrofits.put(baseUrl, RetrofitFactory.getInstance().buildRetrofit(baseUrl));
        }
        return mRetrofits.get(baseUrl);
    }

    // 创建接口服务
    public <T> T createServer(String baseUrl, final Class<T> service) {
        return getDefault(baseUrl).create(service);
    }

    private static class InnerHolder {

        public static RetrofitTool mtNetWork = new RetrofitTool();
    }

}
