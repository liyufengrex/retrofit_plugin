package com.rex.retrofit_plugin.net.base;

import com.rex.retrofit_plugin.RetrofitPlugin;
import java.util.concurrent.TimeUnit;
import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.converter.scalars.ScalarsConverterFactory;

public class RetrofitFactory {

    private RetrofitFactory() {
    }

    private static class RetrofitFactoryHolder {

        private static final RetrofitFactory mRetrofit = new RetrofitFactory();
    }

    public static RetrofitFactory getInstance() {
        return RetrofitFactoryHolder.mRetrofit;
    }

    // 创建 Retrofit
    public Retrofit buildRetrofit(String baseUrl) {
        Retrofit.Builder mRetrofitBuilder = new Retrofit.Builder();
        mRetrofitBuilder.baseUrl(baseUrl);
        mRetrofitBuilder.addConverterFactory(ScalarsConverterFactory.create());
//        mRetrofitBuilder.addConverterFactory(GsonConverterFactory.create());
        mRetrofitBuilder.addCallAdapterFactory(RxJava2CallAdapterFactory.create());
        mRetrofitBuilder.client(buildOkHttpClient());
        return mRetrofitBuilder.build();
    }

    private OkHttpClient buildOkHttpClient() {
        OkHttpClient.Builder mOkHttpClientBuilder = new OkHttpClient.Builder();
        // 添加日志打印
        mOkHttpClientBuilder.addInterceptor(
                new HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY));
        mOkHttpClientBuilder.connectTimeout(RetrofitPlugin.Companion.getTIME_OUT(), TimeUnit.SECONDS);
        mOkHttpClientBuilder.readTimeout(RetrofitPlugin.Companion.getTIME_OUT(), TimeUnit.SECONDS);
        mOkHttpClientBuilder.writeTimeout(RetrofitPlugin.Companion.getTIME_OUT(), TimeUnit.SECONDS);
        //TODO 可添加绕过代理
        return mOkHttpClientBuilder.build();
    }

}
