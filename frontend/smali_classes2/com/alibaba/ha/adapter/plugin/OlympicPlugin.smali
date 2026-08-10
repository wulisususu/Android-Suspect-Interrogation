.class public Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;
.super Ljava/lang/Object;
.source "OlympicPlugin.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/AliHaPlugin;


# static fields
.field public static final DEFAULT_SAMPLE:Ljava/lang/String; = "{\"filterConfigs\":[{\"type\":\"HA_RESOURCE_LEAK\",\"ratio\":[1000,1]},{\"type\":\"HA_MAIN_THREAD_IO\",\"ratio\":[500,1]},{\"type\":\"HA_BIG_BITMAP\",\"ratio\":[200,1]},{\"type\":\"HA_MAIN_THREAD_BLOCK\",\"ratio\":[100,1]},{\"type\":\"HA_MEM_LEAK\",\"ratio\":[50,1]}]}"

.field public static final TAG:Ljava/lang/String; = "OlympicPlugin"


# instance fields
.field public enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

.field public samplingRateMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->samplingRateMap:Ljava/util/Map;

    return-void
.end method

.method public static synthetic access$000(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;Ljava/lang/String;)Z
    .locals 0

    .line 39
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->hitSampling(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method public static synthetic access$100(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;)Ljava/util/Map;
    .locals 0

    .line 39
    iget-object p0, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->samplingRateMap:Ljava/util/Map;

    return-object p0
.end method

.method public static synthetic access$200(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;Ljava/lang/String;)Z
    .locals 0

    .line 39
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->parseSample(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method private hitSampling(Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;)Z
    .locals 2

    .line 292
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    .line 293
    iget v1, p1, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_max_ceil:I

    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    .line 294
    iget v1, p1, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_floor:I

    if-lt v0, v1, :cond_0

    iget p1, p1, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_ceil:I

    if-ge v0, p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method private hitSampling(Ljava/lang/String;)Z
    .locals 1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->samplingRateMap:Ljava/util/Map;

    .line 282
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;

    if-eqz p1, :cond_0

    .line 285
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->hitSampling(Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;)Z

    move-result p1

    return p1

    :cond_0
    const/4 p1, 0x1

    return p1
.end method

.method private initOlympic(Landroid/content/Context;Z)V
    .locals 1

    .line 69
    invoke-static {}, Lcom/taobao/monitor/olympic/common/Global;->instance()Lcom/taobao/monitor/olympic/common/Global;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/taobao/monitor/olympic/common/Global;->setContext(Landroid/content/Context;)V

    .line 70
    invoke-static {p2}, Lcom/taobao/monitor/olympic/common/ActivityManagerProxy;->instance(Z)Lcom/taobao/monitor/olympic/common/ActivityManagerProxy;

    .line 71
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/ha/adapter/AliHaAdapter;->isOpenDebug()Z

    move-result p1

    invoke-static {p1}, Lcom/taobao/monitor/olympic/logger/Logger;->setDebug(Z)V

    .line 73
    invoke-static {}, Lcom/taobao/monitor/olympic/plugins/strictmode/ViolationSubject;->instance()Lcom/taobao/monitor/olympic/plugins/strictmode/ViolationSubject;

    move-result-object p1

    new-instance p2, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;

    invoke-direct {p2, p0}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;-><init>(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;)V

    invoke-virtual {p1, p2}, Lcom/taobao/monitor/olympic/plugins/strictmode/ViolationSubject;->setObserver(Lcom/taobao/monitor/olympic/plugins/strictmode/ViolationSubject$Observer;)V

    .line 174
    new-instance p1, Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;

    invoke-direct {p1}, Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;-><init>()V

    .line 175
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;->detectCustomSlowCalls()Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;

    move-result-object p2

    .line 179
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;->detectResourceMismatches()Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;

    move-result-object p2

    .line 180
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;->detectUnbufferedIo()Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;

    .line 181
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object p2

    invoke-virtual {p2}, Lcom/alibaba/ha/adapter/AliHaAdapter;->isOpenDebug()Z

    move-result p2

    if-eqz p2, :cond_0

    .line 182
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;->penaltyLog()Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;

    .line 184
    :cond_0
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy$Builder;->build()Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy;

    move-result-object p1

    invoke-static {p1}, Lcom/taobao/monitor/olympic/OlympicThreadCompat;->setPolicy(Lcom/taobao/monitor/olympic/OlympicThreadCompat$Policy;)V

    .line 186
    new-instance p1, Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;

    invoke-direct {p1}, Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;-><init>()V

    .line 187
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;->detectNonSdkApiUsage()Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;

    move-result-object p2

    .line 188
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;->detectContentUriWithoutPermission()Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;

    move-result-object p2

    .line 189
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;->detectLeakedClosableObjects()Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;

    move-result-object p2

    .line 190
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;->detectLeakedRegistrationObjects()Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;

    move-result-object p2

    .line 191
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;->detectLeakedSqlLiteObjects()Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;

    .line 192
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object p2

    invoke-virtual {p2}, Lcom/alibaba/ha/adapter/AliHaAdapter;->isOpenDebug()Z

    move-result p2

    if-eqz p2, :cond_1

    .line 193
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;->penaltyLog()Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;

    .line 195
    :cond_1
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy$Builder;->build()Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy;

    move-result-object p1

    invoke-static {p1}, Lcom/taobao/monitor/olympic/OlympicVmCompat;->setPolicy(Lcom/taobao/monitor/olympic/OlympicVmCompat$Policy;)V

    .line 197
    new-instance p1, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;

    invoke-direct {p1}, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;-><init>()V

    .line 198
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;->detectActivityLeaked()Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;

    move-result-object p2

    .line 201
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;->detectMainThreadBlocked()Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;

    move-result-object p2

    .line 202
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;->detectMultiBindService()Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;

    move-result-object p2

    .line 203
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;->detectMultiRegisterReceiver()Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;

    move-result-object p2

    .line 204
    invoke-virtual {p2}, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;->detectOverBitmap()Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;

    .line 205
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object p2

    invoke-virtual {p2}, Lcom/alibaba/ha/adapter/AliHaAdapter;->isOpenDebug()Z

    move-result p2

    if-eqz p2, :cond_2

    .line 206
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;->penaltyLog()Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;

    .line 208
    :cond_2
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy$Builder;->build()Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy;

    move-result-object p1

    invoke-static {p1}, Lcom/taobao/monitor/olympic/OlympicPerformanceCompat;->setPerformancePolicy(Lcom/taobao/monitor/olympic/OlympicPerformanceCompat$Policy;)V

    return-void
.end method

.method private initSample(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 3

    .line 212
    iget-object v0, p1, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    const-string v1, "emas_crash_sample"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "crash_sampling_rate"

    const-string/jumbo v2, "{\"filterConfigs\":[{\"type\":\"HA_RESOURCE_LEAK\",\"ratio\":[1000,1]},{\"type\":\"HA_MAIN_THREAD_IO\",\"ratio\":[500,1]},{\"type\":\"HA_BIG_BITMAP\",\"ratio\":[200,1]},{\"type\":\"HA_MAIN_THREAD_BLOCK\",\"ratio\":[100,1]},{\"type\":\"HA_MEM_LEAK\",\"ratio\":[50,1]}]}"

    .line 213
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 214
    invoke-direct {p0, v0}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->parseSample(Ljava/lang/String;)Z

    .line 216
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->updateSample(Lcom/alibaba/ha/protocol/AliHaParam;)V

    return-void
.end method

.method private parseSample(Ljava/lang/String;)Z
    .locals 7

    .line 244
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 249
    :cond_0
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p1, "filterConfigs"

    .line 250
    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    if-eqz p1, :cond_3

    .line 251
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_3

    .line 252
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    move v2, v1

    .line 253
    :goto_0
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-eq v2, v3, :cond_2

    .line 254
    invoke-virtual {p1, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    if-eqz v3, :cond_1

    const-string v4, "type"

    .line 256
    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "ratio"

    .line 257
    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v3

    .line 259
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_1

    if-eqz v3, :cond_1

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v5

    const/4 v6, 0x2

    if-ne v5, v6, :cond_1

    .line 260
    new-instance v5, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;

    invoke-direct {v5}, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;-><init>()V

    .line 262
    invoke-virtual {v3}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_rate:Ljava/lang/String;

    .line 263
    invoke-virtual {v3, v1}, Lorg/json/JSONArray;->getInt(I)I

    move-result v6

    iput v6, v5, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_max_ceil:I

    const/4 v6, 0x1

    .line 264
    invoke-virtual {v3, v6}, Lorg/json/JSONArray;->getInt(I)I

    move-result v3

    iput v3, v5, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_ceil:I

    .line 265
    iput v1, v5, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_floor:I

    .line 267
    invoke-interface {v0, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    iput-object v0, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->samplingRateMap:Ljava/util/Map;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    .line 275
    invoke-virtual {p1}, Lorg/json/JSONException;->printStackTrace()V

    :cond_3
    :goto_1
    return v1
.end method

.method private updateSample(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 3

    .line 220
    iget-object v0, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    const-string v1, "crash"

    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->getInstance(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/EmasSettingService;

    move-result-object v0

    .line 221
    iget-object v1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appSecret:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->setAppSecret(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/Initializer;

    move-result-object v1

    iget-object v2, p1, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    .line 222
    invoke-interface {v1, v2}, Lcom/alibaba/sdk/android/settingservice/Initializer;->setContext(Landroid/content/Context;)Lcom/alibaba/sdk/android/settingservice/Initializer;

    move-result-object v1

    iget-object v2, p1, Lcom/alibaba/ha/protocol/AliHaParam;->application:Landroid/app/Application;

    .line 223
    invoke-interface {v1, v2}, Lcom/alibaba/sdk/android/settingservice/Initializer;->setApplication(Landroid/app/Application;)Lcom/alibaba/sdk/android/settingservice/Initializer;

    .line 225
    new-instance v1, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$2;

    invoke-direct {v1, p0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$2;-><init>(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;Lcom/alibaba/ha/protocol/AliHaParam;)V

    const-string p1, "crash_sampling_rate"

    const-class v2, Ljava/lang/String;

    invoke-virtual {v0, p1, v2, v1}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->getObject(Ljava/lang/String;Ljava/lang/Class;Lcom/alibaba/sdk/android/settingservice/SettingCallback;)V

    return-void
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    .line 47
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->olympic:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {v0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public start(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 5

    .line 52
    iget-object v0, p1, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    const-string v1, "AliHaAdapter"

    if-nez v0, :cond_0

    const-string p1, "init olympic failed. context is null."

    .line 54
    invoke-static {v1, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_0
    :try_start_0
    iget-object v2, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v3, 0x0

    const/4 v4, 0x1

    .line 59
    invoke-virtual {v2, v3, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 60
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->initSample(Lcom/alibaba/ha/protocol/AliHaParam;)V

    .line 61
    iget-boolean p1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->initAsync:Z

    invoke-direct {p0, v0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->initOlympic(Landroid/content/Context;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 64
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "init olympic exception. "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_0
    return-void
.end method
