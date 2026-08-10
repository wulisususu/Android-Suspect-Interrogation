.class public Lcom/alibaba/sdk/android/settingservice/b/a;
.super Lcom/alibaba/sdk/android/settingservice/EmasSettingService;


# static fields
.field private static final a:Lcom/alibaba/sdk/android/logger/ILog;


# instance fields
.field private final b:Lcom/alibaba/sdk/android/settingservice/a/a;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "EmasSettingService"

    invoke-static {v0}, Lcom/alibaba/sdk/android/settingservice/SettingServiceLog;->getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/settingservice/b/a;->a:Lcom/alibaba/sdk/android/logger/ILog;

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;-><init>()V

    new-instance v0, Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-direct {v0, p1, p2}, Lcom/alibaba/sdk/android/settingservice/a/a;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/settingservice/b/a;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/settingservice/b/a;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "TT;>;TT;Z)TT;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/b/b;

    move-result-object v0

    if-nez v0, :cond_0

    return-object p3

    :cond_0
    iget-object v1, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    if-nez v1, :cond_1

    return-object p3

    :cond_1
    if-nez p4, :cond_2

    iget-wide v1, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->b:J

    const-wide/16 v3, 0x0

    cmp-long p4, v1, v3

    if-lez p4, :cond_2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-wide v3, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->d:J

    sub-long/2addr v1, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->abs(J)J

    move-result-wide v1

    iget-wide v3, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->b:J

    cmp-long p4, v1, v3

    if-ltz p4, :cond_2

    return-object p3

    :cond_2
    const-class p4, Ljava/lang/String;

    const-string v1, "error. "

    const-string v2, "get "

    const-string v3, "service: "

    if-eq p2, p4, :cond_3

    const-class p4, Ljava/lang/Integer;

    if-eq p2, p4, :cond_3

    const-class p4, Ljava/lang/Long;

    if-ne p2, p4, :cond_7

    :cond_3
    iget-object p4, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    invoke-virtual {p4}, Lorg/json/JSONObject;->length()I

    move-result p4

    const/4 v4, 0x1

    if-eq p4, v4, :cond_4

    sget-object p4, Lcom/alibaba/sdk/android/settingservice/b/a;->a:Lcom/alibaba/sdk/android/logger/ILog;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " get "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " error. excepted one "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " config, but actually "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object p2, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    invoke-virtual {p2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p4, p1}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    return-object p3

    :cond_4
    iget-object p4, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    invoke-virtual {p4}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object p4

    invoke-interface {p4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Ljava/lang/String;

    :try_start_0
    const-class v4, Ljava/lang/String;

    if-ne p2, v4, :cond_5

    iget-object v0, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    invoke-virtual {v0, p4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_5
    const-class v4, Ljava/lang/Integer;

    if-ne p2, v4, :cond_6

    iget-object v0, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    invoke-virtual {v0, p4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result p4

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1

    :cond_6
    const-class v4, Ljava/lang/Long;

    if-ne p2, v4, :cond_7

    iget-object v0, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    invoke-virtual {v0, p4}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :cond_7
    :try_start_1
    iget-object p4, v0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    invoke-virtual {p4}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p4

    invoke-static {p4, p2}, Lcom/alibaba/fastjson/JSON;->parseObject(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p4

    sget-object v0, Lcom/alibaba/sdk/android/settingservice/b/a;->a:Lcom/alibaba/sdk/android/logger/ILog;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, p4}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_0
    return-object p3

    :catch_0
    move-exception p4

    sget-object v0, Lcom/alibaba/sdk/android/settingservice/b/a;->a:Lcom/alibaba/sdk/android/logger/ILog;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, p4}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-object p3
.end method


# virtual methods
.method public a(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/b/a;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->b(Ljava/lang/String;)V

    return-object p0
.end method

.method public a()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->c(Ljava/lang/String;)V

    return-void
.end method

.method public synthetic addPreloadService(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/PreLoader;
    .locals 0

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/settingservice/b/a;->a(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/b/a;

    move-result-object p1

    return-object p1
.end method

.method public getBoolean(Ljava/lang/String;)Z
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/alibaba/sdk/android/settingservice/b/a;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    return p1
.end method

.method public getBoolean(Ljava/lang/String;Z)Z
    .locals 1

    const-class v0, Ljava/lang/Boolean;

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    invoke-virtual {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/settingservice/b/a;->getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    return p1
.end method

.method public getDouble(Ljava/lang/String;)D
    .locals 2

    const-wide/16 v0, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/alibaba/sdk/android/settingservice/b/a;->getDouble(Ljava/lang/String;D)D

    move-result-wide v0

    return-wide v0
.end method

.method public getDouble(Ljava/lang/String;D)D
    .locals 1

    const-class v0, Ljava/lang/Double;

    invoke-static {p2, p3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p2

    invoke-virtual {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/settingservice/b/a;->getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Double;

    invoke-virtual {p1}, Ljava/lang/Double;->doubleValue()D

    move-result-wide p1

    return-wide p1
.end method

.method public getFloat(Ljava/lang/String;)F
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/alibaba/sdk/android/settingservice/b/a;->getFloat(Ljava/lang/String;F)F

    move-result p1

    return p1
.end method

.method public getFloat(Ljava/lang/String;F)F
    .locals 1

    const-class v0, Ljava/lang/Float;

    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p2

    invoke-virtual {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/settingservice/b/a;->getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Float;

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result p1

    return p1
.end method

.method public getInt(Ljava/lang/String;)I
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/alibaba/sdk/android/settingservice/b/a;->getInt(Ljava/lang/String;I)I

    move-result p1

    return p1
.end method

.method public getInt(Ljava/lang/String;I)I
    .locals 1

    const-class v0, Ljava/lang/Integer;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-virtual {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/settingservice/b/a;->getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    return p1
.end method

.method public getLong(Ljava/lang/String;)J
    .locals 2

    const-wide/16 v0, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/alibaba/sdk/android/settingservice/b/a;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method

.method public getLong(Ljava/lang/String;J)J
    .locals 1

    const-class v0, Ljava/lang/Long;

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-virtual {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/settingservice/b/a;->getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Long;

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide p1

    return-wide p1
.end method

.method public getObject(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "TT;>;)TT;"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/alibaba/sdk/android/settingservice/b/a;->getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "TT;>;TT;)TT;"
        }
    .end annotation

    const/4 v0, 0x1

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/alibaba/sdk/android/settingservice/b/a;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;

    move-result-object p2

    iget-object p3, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {p3, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->c(Ljava/lang/String;)V

    return-object p2
.end method

.method public getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "TT;>;TT;Z)TT;"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0, p4}, Lcom/alibaba/sdk/android/settingservice/b/a;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object p2, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {p2, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->c(Ljava/lang/String;)V

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->d(Ljava/lang/String;)V

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/settingservice/b/a;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public getObject(Ljava/lang/String;Ljava/lang/Class;Lcom/alibaba/sdk/android/settingservice/SettingCallback;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "TT;>;",
            "Lcom/alibaba/sdk/android/settingservice/SettingCallback<",
            "TT;>;)V"
        }
    .end annotation

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, p1, p2, v0, v1}, Lcom/alibaba/sdk/android/settingservice/b/a;->a(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;

    move-result-object v0

    if-eqz p3, :cond_1

    if-eqz v0, :cond_0

    invoke-interface {p3, p1, v0}, Lcom/alibaba/sdk/android/settingservice/SettingCallback;->onSuccess(Ljava/lang/String;Ljava/lang/Object;)V

    const/4 v1, 0x1

    :cond_0
    move v6, v1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    new-instance v1, Lcom/alibaba/sdk/android/settingservice/b/a$1;

    move-object v2, v1

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    move-object v7, p3

    invoke-direct/range {v2 .. v7}, Lcom/alibaba/sdk/android/settingservice/b/a$1;-><init>(Lcom/alibaba/sdk/android/settingservice/b/a;Ljava/lang/String;Ljava/lang/Class;ZLcom/alibaba/sdk/android/settingservice/SettingCallback;)V

    invoke-virtual {v0, p1, v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Ljava/lang/String;Lcom/alibaba/sdk/android/settingservice/a/b;)V

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {p2, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->c(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public getString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    const-string v0, ""

    invoke-virtual {p0, p1, v0}, Lcom/alibaba/sdk/android/settingservice/b/a;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    const-class v0, Ljava/lang/String;

    invoke-virtual {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/settingservice/b/a;->getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    return-object p1
.end method

.method public openHttp(Z)Lcom/alibaba/sdk/android/settingservice/Initializer;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Z)V

    return-object p0
.end method

.method public preload()V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/settingservice/a/a;->a()V

    return-void
.end method

.method public setAppSecret(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/Initializer;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->e(Ljava/lang/String;)V

    return-object p0
.end method

.method public setApplication(Landroid/app/Application;)Lcom/alibaba/sdk/android/settingservice/Initializer;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Landroid/app/Application;)V

    invoke-static {}, Lcom/alibaba/sdk/android/settingservice/b/c;->a()Lcom/alibaba/sdk/android/settingservice/b/c;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/b/c;->a(Landroid/app/Application;)V

    return-object p0
.end method

.method public setContext(Landroid/content/Context;)Lcom/alibaba/sdk/android/settingservice/Initializer;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Landroid/content/Context;)V

    return-object p0
.end method

.method public setHost(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/Initializer;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->g(Ljava/lang/String;)V

    return-object p0
.end method

.method public setSdkVersion(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/Initializer;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a;->b:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->f(Ljava/lang/String;)V

    return-object p0
.end method
