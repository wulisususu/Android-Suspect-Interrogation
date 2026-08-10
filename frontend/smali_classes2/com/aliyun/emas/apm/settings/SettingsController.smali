.class public Lcom/aliyun/emas/apm/settings/SettingsController;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/settings/SettingProvider;
.implements Lcom/google/android/gms/common/api/internal/BackgroundDetector$BackgroundStateChangeListener;


# instance fields
.field private final a:Ljava/util/concurrent/atomic/AtomicReference;

.field private final b:Ljava/util/concurrent/atomic/AtomicReference;

.field private final c:Lcom/aliyun/emas/apm/c;

.field private final d:Ljava/lang/String;

.field private final e:Ljava/lang/String;

.field private final f:Lcom/aliyun/emas/apm/settings/Settings;

.field private g:J

.field private h:Lcom/aliyun/emas/apm/ApmOptions;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/ApmOptions;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->a:Ljava/util/concurrent/atomic/AtomicReference;

    .line 3
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    new-instance v1, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-direct {v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->b:Ljava/util/concurrent/atomic/AtomicReference;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->g:J

    iput-object p2, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->d:Ljava/lang/String;

    iput-object p3, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->e:Ljava/lang/String;

    iput-object p4, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->h:Lcom/aliyun/emas/apm/ApmOptions;

    .line 16
    new-instance p2, Lcom/aliyun/emas/apm/c;

    invoke-direct {p2, p1}, Lcom/aliyun/emas/apm/c;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->c:Lcom/aliyun/emas/apm/c;

    .line 18
    invoke-direct {p0}, Lcom/aliyun/emas/apm/settings/SettingsController;->c()V

    .line 19
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 20
    new-instance p2, Lcom/aliyun/emas/apm/settings/Settings$a;

    const/4 p3, 0x1

    const-string p4, "crash"

    invoke-direct {p2, p3, p4}, Lcom/aliyun/emas/apm/settings/Settings$a;-><init>(ZLjava/lang/String;)V

    invoke-interface {p1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 21
    new-instance p2, Lcom/aliyun/emas/apm/settings/Settings;

    invoke-direct {p2, p1}, Lcom/aliyun/emas/apm/settings/Settings;-><init>(Ljava/util/List;)V

    iput-object p2, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->f:Lcom/aliyun/emas/apm/settings/Settings;

    .line 23
    invoke-static {}, Lcom/google/android/gms/common/api/internal/BackgroundDetector;->getInstance()Lcom/google/android/gms/common/api/internal/BackgroundDetector;

    move-result-object p1

    invoke-virtual {p1, p0}, Lcom/google/android/gms/common/api/internal/BackgroundDetector;->addListener(Lcom/google/android/gms/common/api/internal/BackgroundDetector$BackgroundStateChangeListener;)V

    .line 24
    invoke-direct {p0}, Lcom/aliyun/emas/apm/settings/SettingsController;->d()V

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->h:Lcom/aliyun/emas/apm/ApmOptions;

    if-eqz v0, :cond_0

    .line 3
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/ApmOptions;->isOnline()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "https://pre-setting-emas.aliyuncs.com/api/v1/sample"

    goto :goto_0

    :cond_0
    const-string v0, "https://setting-emas.aliyuncs.com/api/v1/sample"

    .line 6
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "appId="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, "@android&timestamp="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {p1, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 8
    invoke-static {p1, p2}, Lcom/aliyun/emas/apm/util/HmacUtils;->getHmac(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 9
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "?"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "&sign="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private a()Lorg/json/JSONObject;
    .locals 7

    const-string v0, "settings request code: "

    const/4 v1, 0x0

    .line 10
    :try_start_0
    new-instance v2, Ljava/net/URL;

    iget-object v3, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->d:Ljava/lang/String;

    iget-object v4, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->e:Ljava/lang/String;

    invoke-direct {p0, v3, v4}, Lcom/aliyun/emas/apm/settings/SettingsController;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 11
    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v2

    check-cast v2, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    const/16 v3, 0x2710

    .line 12
    :try_start_1
    invoke-virtual {v2, v3}, Ljava/net/URLConnection;->setReadTimeout(I)V

    .line 13
    invoke-virtual {v2, v3}, Ljava/net/URLConnection;->setConnectTimeout(I)V

    .line 15
    invoke-virtual {v2}, Ljava/net/URLConnection;->connect()V

    .line 17
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v3

    const/16 v4, 0xc8

    if-ne v3, v4, :cond_0

    .line 18
    invoke-virtual {v2}, Ljava/net/URLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v0
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_5
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 19
    :try_start_2
    invoke-static {v0}, Lcom/aliyun/emas/apm/util/CommonUtils;->streamToString(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v3

    .line 21
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, v3}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v3, "success"

    .line 22
    invoke-virtual {v4, v3}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v1, "data"

    .line 24
    invoke-virtual {v4, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 36
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 39
    invoke-static {v0}, Lcom/aliyun/emas/apm/util/CommonUtils;->closeSafely(Ljava/io/Closeable;)V

    return-object v1

    :catchall_0
    move-exception v1

    move-object v3, v0

    goto :goto_6

    :catch_0
    move-exception v1

    :goto_0
    move-object v3, v0

    goto :goto_5

    :catch_1
    move-exception v1

    goto :goto_0

    .line 40
    :cond_0
    :try_start_3
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object v3
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_5
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 41
    :try_start_4
    invoke-static {v3}, Lcom/aliyun/emas/apm/util/CommonUtils;->streamToString(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "Apm"

    .line 43
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, ", msg: "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_4
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_3
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    move-object v0, v3

    .line 49
    :cond_1
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 52
    invoke-static {v0}, Lcom/aliyun/emas/apm/util/CommonUtils;->closeSafely(Ljava/io/Closeable;)V

    return-object v1

    :catch_2
    move-exception v1

    goto :goto_5

    :catch_3
    move-exception v1

    goto :goto_5

    :catchall_1
    move-exception v0

    move-object v3, v1

    goto :goto_2

    :catch_4
    move-exception v0

    :goto_1
    move-object v3, v1

    goto :goto_4

    :catch_5
    move-exception v0

    goto :goto_1

    :catchall_2
    move-exception v0

    move-object v2, v1

    move-object v3, v2

    :goto_2
    move-object v1, v0

    goto :goto_6

    :catch_6
    move-exception v0

    :goto_3
    move-object v2, v1

    move-object v3, v2

    :goto_4
    move-object v1, v0

    goto :goto_5

    :catch_7
    move-exception v0

    goto :goto_3

    .line 53
    :goto_5
    :try_start_5
    throw v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    :catchall_3
    move-exception v1

    :goto_6
    if-eqz v2, :cond_2

    .line 56
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 59
    :cond_2
    invoke-static {v3}, Lcom/aliyun/emas/apm/util/CommonUtils;->closeSafely(Ljava/io/Closeable;)V

    .line 60
    throw v1
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/settings/SettingsController;)Lorg/json/JSONObject;
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/settings/SettingsController;->a()Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method private b()Lcom/aliyun/emas/apm/settings/Settings;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->c:Lcom/aliyun/emas/apm/c;

    .line 2
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/c;->b()Lorg/json/JSONObject;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 6
    :try_start_0
    invoke-static {v0}, Lcom/aliyun/emas/apm/settings/a;->a(Lorg/json/JSONObject;)Lcom/aliyun/emas/apm/settings/Settings;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method static synthetic b(Lcom/aliyun/emas/apm/settings/SettingsController;)Ljava/util/concurrent/atomic/AtomicReference;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->a:Ljava/util/concurrent/atomic/AtomicReference;

    return-object p0
.end method

.method static synthetic c(Lcom/aliyun/emas/apm/settings/SettingsController;)Ljava/util/concurrent/atomic/AtomicReference;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->b:Ljava/util/concurrent/atomic/AtomicReference;

    return-object p0
.end method

.method private c()V
    .locals 2

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/settings/SettingsController;->b()Lcom/aliyun/emas/apm/settings/Settings;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->a:Ljava/util/concurrent/atomic/AtomicReference;

    .line 4
    invoke-virtual {v1, v0}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->b:Ljava/util/concurrent/atomic/AtomicReference;

    .line 5
    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-virtual {v1, v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method static synthetic d(Lcom/aliyun/emas/apm/settings/SettingsController;)Lcom/aliyun/emas/apm/c;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->c:Lcom/aliyun/emas/apm/c;

    return-object p0
.end method

.method private d()V
    .locals 2

    .line 2
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/aliyun/emas/apm/settings/SettingsController$a;

    invoke-direct {v1, p0}, Lcom/aliyun/emas/apm/settings/SettingsController$a;-><init>(Lcom/aliyun/emas/apm/settings/SettingsController;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 23
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method private e()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->a:Ljava/util/concurrent/atomic/AtomicReference;

    .line 2
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->a:Ljava/util/concurrent/atomic/AtomicReference;

    iget-object v1, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->f:Lcom/aliyun/emas/apm/settings/Settings;

    .line 3
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->b:Ljava/util/concurrent/atomic/AtomicReference;

    .line 4
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    iget-object v1, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->f:Lcom/aliyun/emas/apm/settings/Settings;

    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method static synthetic e(Lcom/aliyun/emas/apm/settings/SettingsController;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/settings/SettingsController;->e()V

    return-void
.end method


# virtual methods
.method public getSettingsAsync()Lcom/google/android/gms/tasks/Task;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/aliyun/emas/apm/settings/Settings;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->b:Ljava/util/concurrent/atomic/AtomicReference;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-virtual {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method

.method public getSettingsSync()Lcom/aliyun/emas/apm/settings/Settings;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->a:Ljava/util/concurrent/atomic/AtomicReference;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/settings/Settings;

    return-object v0
.end method

.method public onBackgroundStateChanged(Z)V
    .locals 4

    if-eqz p1, :cond_0

    .line 1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->g:J

    goto :goto_0

    :cond_0
    iget-wide v0, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->g:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-eqz p1, :cond_1

    .line 3
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/aliyun/emas/apm/settings/SettingsController;->g:J

    sub-long/2addr v0, v2

    const-wide/32 v2, 0x1b7740

    cmp-long p1, v0, v2

    if-ltz p1, :cond_1

    .line 5
    invoke-direct {p0}, Lcom/aliyun/emas/apm/settings/SettingsController;->d()V

    :cond_1
    :goto_0
    return-void
.end method
