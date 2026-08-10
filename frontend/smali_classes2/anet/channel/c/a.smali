.class public Lanet/channel/c/a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanetwork/channel/config/IRemoteConfig;


# static fields
.field private static a:Z = false


# direct methods
.method static constructor <clinit>()V
    .locals 1

    :try_start_0
    const-string v0, "com.taobao.orange.OrangeConfig"

    .line 72
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    const/4 v0, 0x1

    sput-boolean v0, Lanet/channel/c/a;->a:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    sput-boolean v0, Lanet/channel/c/a;->a:Z

    :goto_0
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs getConfig([Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    sget-boolean v0, Lanet/channel/c/a;->a:Z

    const-string v1, "awcn.OrangeConfigImpl"

    const/4 v2, 0x0

    const/4 v3, 0x0

    if-nez v0, :cond_0

    const-string p1, "no orange sdk"

    new-array v0, v2, [Ljava/lang/Object;

    .line 114
    invoke-static {v1, p1, v3, v0}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v3

    .line 119
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/taobao/orange/OrangeConfig;->getInstance()Lcom/taobao/orange/OrangeConfig;

    move-result-object v0

    aget-object v4, p1, v2

    const/4 v5, 0x1

    aget-object v5, p1, v5

    const/4 v6, 0x2

    aget-object p1, p1, v6

    invoke-virtual {v0, v4, v5, p1}, Lcom/taobao/orange/OrangeConfig;->getConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    const-string v0, "get config failed!"

    new-array v2, v2, [Ljava/lang/Object;

    .line 121
    invoke-static {v1, v0, v3, p1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-object v3
.end method

.method public onConfigUpdate(Ljava/lang/String;)V
    .locals 9

    const-string v0, "true"

    const-string v1, "networkSdk"

    .line 128
    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1d

    const-string v1, "namespace"

    .line 129
    filled-new-array {v1, p1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "awcn.OrangeConfigImpl"

    const-string v3, "onConfigUpdate"

    const/4 v4, 0x0

    invoke-static {v2, v3, v4, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v1, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x3

    const/4 v5, 0x0

    :try_start_0
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_empty_scheme_https_switch"

    aput-object v7, v6, v2

    aput-object v0, v6, v1

    .line 133
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .line 1016
    sget-object v7, Lanet/channel/strategy/c$a;->a:Lanet/channel/strategy/c;

    .line 134
    invoke-virtual {v7, v6}, Lanet/channel/strategy/c;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_spdy_enable_switch"

    aput-object v7, v6, v2

    aput-object v0, v6, v1

    .line 141
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .line 142
    invoke-static {v6}, Lanetwork/channel/config/NetworkConfigCenter;->setSpdyEnabled(Z)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_http_cache_switch"

    aput-object v7, v6, v2

    aput-object v0, v6, v1

    .line 149
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .line 150
    invoke-static {v6}, Lanetwork/channel/config/NetworkConfigCenter;->setHttpCacheEnable(Z)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_http_cache_flag"

    aput-object v7, v6, v2

    aput-object v4, v6, v1

    .line 156
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_0

    .line 158
    invoke-static {v6}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    invoke-static {v6, v7}, Lanetwork/channel/config/NetworkConfigCenter;->setCacheFlag(J)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :cond_0
    :try_start_4
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_https_sni_enable_switch"

    aput-object v7, v6, v2

    aput-object v0, v6, v1

    .line 165
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .line 166
    invoke-static {v6}, Lanet/channel/AwcnConfig;->setHttpsSniEnable(Z)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :try_start_5
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_accs_session_bg_switch"

    aput-object v7, v6, v2

    aput-object v0, v6, v1

    .line 173
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .line 174
    invoke-static {v6}, Lanet/channel/AwcnConfig;->setAccsSessionCreateForbiddenInBg(Z)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_5

    :catch_5
    :try_start_6
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_request_statistic_sample_rate"

    aput-object v7, v6, v2

    const-string v7, "10000"

    aput-object v7, v6, v1

    .line 180
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    .line 181
    invoke-static {v6}, Lanetwork/channel/config/NetworkConfigCenter;->setRequestStatisticSampleRate(I)V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_6

    :catch_6
    :try_start_7
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_request_forbidden_bg"

    aput-object v7, v6, v2

    aput-object v4, v6, v1

    .line 187
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 188
    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_1

    .line 189
    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .line 190
    invoke-static {v6}, Lanetwork/channel/config/NetworkConfigCenter;->setBgRequestForbidden(Z)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_7

    :catch_7
    :cond_1
    :try_start_8
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_url_white_list_bg"

    aput-object v7, v6, v2

    aput-object v4, v6, v1

    .line 197
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lanetwork/channel/config/NetworkConfigCenter;->updateWhiteListMap(Ljava/lang/String;)V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_8

    :catch_8
    :try_start_9
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_biz_white_list_bg"

    aput-object v7, v6, v2

    aput-object v4, v6, v1

    .line 203
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 204
    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_2

    .line 205
    invoke-static {v6}, Lanetwork/channel/config/NetworkConfigCenter;->updateBizWhiteList(Ljava/lang/String;)V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_9

    :catch_9
    :cond_2
    :try_start_a
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_amdc_preset_hosts"

    aput-object v7, v6, v2

    aput-object v4, v6, v1

    .line 212
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 213
    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_3

    .line 214
    invoke-static {v6}, Lanetwork/channel/config/NetworkConfigCenter;->setAmdcPresetHosts(Ljava/lang/String;)V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_a

    :catch_a
    :cond_3
    :try_start_b
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_horse_race_switch"

    aput-object v7, v6, v2

    aput-object v0, v6, v1

    .line 221
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .line 222
    invoke-static {v6}, Lanet/channel/AwcnConfig;->setHorseRaceEnable(Z)V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_b

    :catch_b
    :try_start_c
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "tnet_enable_header_cache"

    aput-object v7, v6, v2

    aput-object v0, v6, v1

    .line 228
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .line 229
    invoke-static {v6}, Lanet/channel/AwcnConfig;->setTnetHeaderCacheEnable(Z)V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_c

    :catch_c
    :try_start_d
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_http3_enable_switch"

    aput-object v7, v6, v2

    aput-object v4, v6, v1

    .line 235
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 236
    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_4

    .line 237
    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .line 238
    invoke-static {}, Lanetwork/channel/http/NetworkSdkSetting;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-static {v7}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v7

    invoke-interface {v7}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v7

    const-string v8, "HTTP3_ENABLE"

    .line 239
    invoke-interface {v7, v8, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 240
    invoke-interface {v7}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 241
    invoke-static {v6}, Lanet/channel/AwcnConfig;->setHttp3OrangeEnable(Z)V

    if-nez v6, :cond_4

    .line 243
    invoke-static {v5}, Lanet/channel/AwcnConfig;->setHttp3Enable(Z)V
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_d

    :catch_d
    :cond_4
    :try_start_e
    new-array v6, v3, [Ljava/lang/String;

    aput-object p1, v6, v5

    const-string v7, "network_response_buffer_switch"

    aput-object v7, v6, v2

    aput-object v0, v6, v1

    .line 251
    invoke-virtual {p0, v6}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 252
    invoke-static {v0}, Lanetwork/channel/config/NetworkConfigCenter;->setResponseBufferEnable(Z)V
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_e

    :catch_e
    :try_start_f
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_get_session_async_switch"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 258
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 259
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_5

    .line 260
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 261
    invoke-static {}, Lanetwork/channel/http/NetworkSdkSetting;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-static {v6}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v6

    invoke-interface {v6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    const-string v7, "SESSION_ASYNC_OPTIMIZE"

    .line 262
    invoke-interface {v6, v7, v0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 263
    invoke-interface {v6}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_f

    :catch_f
    :cond_5
    :try_start_10
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_bg_forbid_request_threshold"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 270
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 271
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_7

    .line 272
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-gez v0, :cond_6

    move v0, v5

    .line 276
    :cond_6
    invoke-static {v0}, Lanetwork/channel/config/NetworkConfigCenter;->setBgForbidRequestThreshold(I)V
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_10

    :catch_10
    :cond_7
    :try_start_11
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_normal_thread_pool_executor_size"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 283
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 284
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_8

    .line 285
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 286
    invoke-static {v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->setNormalExecutorPoolSize(I)V
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_11

    :catch_11
    :cond_8
    :try_start_12
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_idle_session_close_switch"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 293
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 294
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_9

    .line 295
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 296
    invoke-static {v0}, Lanet/channel/AwcnConfig;->setIdleSessionCloseEnable(Z)V
    :try_end_12
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_12

    :catch_12
    :cond_9
    :try_start_13
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_monitor_requests"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 303
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 304
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_a

    .line 305
    invoke-static {v0}, Lanetwork/channel/config/NetworkConfigCenter;->setMonitorRequestList(Ljava/lang/String;)V
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_13

    :catch_13
    :cond_a
    :try_start_14
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_session_preset_hosts"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 312
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 313
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_b

    .line 314
    invoke-static {v0}, Lanet/channel/AwcnConfig;->registerPresetSessions(Ljava/lang/String;)V
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_14

    :catch_14
    :cond_b
    :try_start_15
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_ipv6_blacklist_switch"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 321
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 322
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_c

    .line 323
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 324
    invoke-static {v0}, Lanet/channel/AwcnConfig;->setIpv6BlackListEnable(Z)V
    :try_end_15
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_15

    :catch_15
    :cond_c
    :try_start_16
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_ipv6_blacklist_ttl"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 329
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 330
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_d

    .line 331
    invoke-static {v0}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    .line 332
    invoke-static {v6, v7}, Lanet/channel/AwcnConfig;->setIpv6BlackListTtl(J)V
    :try_end_16
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_16

    :catch_16
    :cond_d
    :try_start_17
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_url_degrade_list"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 339
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 340
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_e

    .line 341
    invoke-static {v0}, Lanetwork/channel/config/NetworkConfigCenter;->setDegradeRequestList(Ljava/lang/String;)V
    :try_end_17
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_17

    :catch_17
    :cond_e
    :try_start_18
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_delay_retry_request_no_network"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 349
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 350
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_f

    .line 351
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 352
    invoke-static {v0}, Lanetwork/channel/config/NetworkConfigCenter;->setRequestDelayRetryForNoNetwork(Z)V
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_18

    :catch_18
    :cond_f
    :try_start_19
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_bind_service_optimize"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 359
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 360
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_10

    .line 361
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 362
    invoke-static {}, Lanetwork/channel/http/NetworkSdkSetting;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-static {v6}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v6

    invoke-interface {v6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    const-string v7, "SERVICE_OPTIMIZE"

    .line 363
    invoke-interface {v6, v7, v0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 364
    invoke-interface {v6}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_19
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_19} :catch_19

    :catch_19
    :cond_10
    :try_start_1a
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_forbid_next_launch_optimize"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 371
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 372
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_11

    .line 373
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 374
    invoke-static {}, Lanetwork/channel/http/NetworkSdkSetting;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-static {v6}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v6

    invoke-interface {v6}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    const-string v7, "NEXT_LAUNCH_FORBID"

    .line 375
    invoke-interface {v6, v7, v0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 376
    invoke-interface {v6}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_1a
    .catch Ljava/lang/Exception; {:try_start_1a .. :try_end_1a} :catch_1a

    :catch_1a
    :cond_11
    :try_start_1b
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_detect_enable_switch"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 383
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 384
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_12

    .line 385
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 386
    invoke-static {v0}, Lanet/channel/AwcnConfig;->setNetworkDetectEnable(Z)V
    :try_end_1b
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1b} :catch_1b

    :catch_1b
    :cond_12
    :try_start_1c
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_ping6_enable_switch"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 393
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 394
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_13

    .line 395
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 396
    invoke-static {v0}, Lanet/channel/AwcnConfig;->setPing6Enable(Z)V
    :try_end_1c
    .catch Ljava/lang/Exception; {:try_start_1c .. :try_end_1c} :catch_1c

    :catch_1c
    :cond_13
    :try_start_1d
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_ipv6_global_enable_swtich"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 403
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 404
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_14

    .line 405
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 406
    invoke-static {v0}, Lanet/channel/AwcnConfig;->setIpv6Enable(Z)V
    :try_end_1d
    .catch Ljava/lang/Exception; {:try_start_1d .. :try_end_1d} :catch_1d

    :catch_1d
    :cond_14
    :try_start_1e
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_xquic_cong_control"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 413
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 414
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_15

    .line 415
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 416
    invoke-static {v0}, Lanet/channel/AwcnConfig;->setXquicCongControl(I)V
    :try_end_1e
    .catch Ljava/lang/Exception; {:try_start_1e .. :try_end_1e} :catch_1e

    :catch_1e
    :cond_15
    :try_start_1f
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_http3_detect_valid_time"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 422
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 423
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_16

    .line 424
    invoke-static {v0}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    .line 425
    invoke-static {v6, v7}, Lanet/channel/e/a;->a(J)V
    :try_end_1f
    .catch Ljava/lang/Exception; {:try_start_1f .. :try_end_1f} :catch_1f

    :catch_1f
    :cond_16
    :try_start_20
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_ip_stack_detect_by_udp_connect_enable_switch"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 432
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 433
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_17

    .line 434
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 435
    invoke-static {v0}, Lanet/channel/AwcnConfig;->setIpStackDetectByUdpConnect(Z)V
    :try_end_20
    .catch Ljava/lang/Exception; {:try_start_20 .. :try_end_20} :catch_20

    :catch_20
    :cond_17
    :try_start_21
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_cookie_monitor"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 442
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 443
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_18

    .line 444
    invoke-static {v0}, Lanetwork/channel/cookie/CookieManager;->setTargetMonitorCookieName(Ljava/lang/String;)V
    :try_end_21
    .catch Ljava/lang/Exception; {:try_start_21 .. :try_end_21} :catch_21

    :catch_21
    :cond_18
    :try_start_22
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_cookie_header_redundant_fix"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 451
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 452
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_19

    .line 453
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 454
    invoke-static {v0}, Lanet/channel/AwcnConfig;->setCookieHeaderRedundantFix(Z)V
    :try_end_22
    .catch Ljava/lang/Exception; {:try_start_22 .. :try_end_22} :catch_22

    :catch_22
    :cond_19
    :try_start_23
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_channel_local_instance_enable_switch"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 461
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 462
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_1a

    .line 463
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 464
    invoke-static {v0}, Lanetwork/channel/config/NetworkConfigCenter;->setChannelLocalInstanceEnable(Z)V
    :try_end_23
    .catch Ljava/lang/Exception; {:try_start_23 .. :try_end_23} :catch_23

    :catch_23
    :cond_1a
    :try_start_24
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_allow_spdy_when_bind_service_failed"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 471
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 472
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_1b

    .line 473
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 474
    invoke-static {v0}, Lanetwork/channel/config/NetworkConfigCenter;->setAllowSpdyWhenBindServiceFailed(Z)V
    :try_end_24
    .catch Ljava/lang/Exception; {:try_start_24 .. :try_end_24} :catch_24

    :catch_24
    :cond_1b
    :try_start_25
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string v6, "network_send_connect_info_by_service"

    aput-object v6, v0, v2

    aput-object v4, v0, v1

    .line 481
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 482
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_1c

    .line 483
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 484
    invoke-static {v0}, Lanet/channel/AwcnConfig;->setSendConnectInfoByService(Z)V
    :try_end_25
    .catch Ljava/lang/Exception; {:try_start_25 .. :try_end_25} :catch_25

    :catch_25
    :cond_1c
    :try_start_26
    new-array v0, v3, [Ljava/lang/String;

    aput-object p1, v0, v5

    const-string p1, "network_http_dns_notify_white_list"

    aput-object p1, v0, v2

    aput-object v4, v0, v1

    .line 491
    invoke-virtual {p0, v0}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 492
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1d

    .line 493
    invoke-static {p1}, Lanet/channel/AwcnConfig;->setHttpDnsNotifyWhiteList(Ljava/lang/String;)V
    :try_end_26
    .catch Ljava/lang/Exception; {:try_start_26 .. :try_end_26} :catch_26

    :catch_26
    :cond_1d
    return-void
.end method

.method public register()V
    .locals 8

    const-string v0, "networkSdk"

    sget-boolean v1, Lanet/channel/c/a;->a:Z

    const/4 v2, 0x0

    const-string v3, "awcn.OrangeConfigImpl"

    const/4 v4, 0x0

    if-nez v1, :cond_0

    const-string v0, "no orange sdk"

    new-array v1, v4, [Ljava/lang/Object;

    .line 83
    invoke-static {v3, v0, v2, v1}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 88
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/taobao/orange/OrangeConfig;->getInstance()Lcom/taobao/orange/OrangeConfig;

    move-result-object v1

    const/4 v5, 0x1

    new-array v6, v5, [Ljava/lang/String;

    aput-object v0, v6, v4

    new-instance v7, Lanet/channel/c/b;

    invoke-direct {v7, p0}, Lanet/channel/c/b;-><init>(Lanet/channel/c/a;)V

    invoke-virtual {v1, v6, v7}, Lcom/taobao/orange/OrangeConfig;->registerListener([Ljava/lang/String;Lcom/taobao/orange/OrangeConfigListenerV1;)V

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/String;

    aput-object v0, v1, v4

    const-string v0, "network_empty_scheme_https_switch"

    aput-object v0, v1, v5

    const-string v0, "true"

    const/4 v5, 0x2

    aput-object v0, v1, v5

    .line 95
    invoke-virtual {p0, v1}, Lanet/channel/c/a;->getConfig([Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "register fail"

    new-array v4, v4, [Ljava/lang/Object;

    .line 97
    invoke-static {v3, v1, v2, v0, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method

.method public unRegister()V
    .locals 4

    sget-boolean v0, Lanet/channel/c/a;->a:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "awcn.OrangeConfigImpl"

    const-string v2, "no orange sdk"

    const/4 v3, 0x0

    .line 104
    invoke-static {v1, v2, v3, v0}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 108
    :cond_0
    invoke-static {}, Lcom/taobao/orange/OrangeConfig;->getInstance()Lcom/taobao/orange/OrangeConfig;

    move-result-object v0

    const-string v1, "networkSdk"

    filled-new-array {v1}, [Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/taobao/orange/OrangeConfig;->unregisterListener([Ljava/lang/String;)V

    return-void
.end method
