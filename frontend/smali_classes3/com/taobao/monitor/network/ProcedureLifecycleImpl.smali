.class public Lcom/taobao/monitor/network/ProcedureLifecycleImpl;
.super Ljava/lang/Object;
.source "ProcedureLifecycleImpl.java"

# interfaces
.implements Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;


# static fields
.field private static final TAG:Ljava/lang/String; = "NetworkDataUpdate"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/taobao/monitor/network/ProcedureLifecycleImpl;Lcom/taobao/monitor/procedure/Value;)V
    .locals 0

    .line 18
    invoke-direct {p0, p1}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->doSendData(Lcom/taobao/monitor/procedure/Value;)V

    return-void
.end method

.method private doSendData(Lcom/taobao/monitor/procedure/Value;)V
    .locals 5
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "value"
        }
    .end annotation

    .line 54
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "version"

    .line 57
    sget-object v2, Lcom/taobao/monitor/procedure/Header;->apmVersion:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "topic"

    .line 58
    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->topic()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 59
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    const-string v2, "X-timestamp"

    .line 60
    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->timestamp()J

    move-result-wide v3

    invoke-virtual {v1, v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-appId"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->appId:Ljava/lang/String;

    .line 61
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-appKey"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->appKey:Ljava/lang/String;

    .line 62
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-appBuild"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->appBuild:Ljava/lang/String;

    .line 63
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-appPatch"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->appPatch:Ljava/lang/String;

    .line 64
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-channel"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->channel:Ljava/lang/String;

    .line 65
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-utdid"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->utdid:Ljava/lang/String;

    .line 66
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-brand"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->brand:Ljava/lang/String;

    .line 67
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-deviceModel"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->deviceModel:Ljava/lang/String;

    .line 68
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-os"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->os:Ljava/lang/String;

    .line 69
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-osVersion"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->osVersion:Ljava/lang/String;

    .line 70
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-userId"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->userId:Ljava/lang/String;

    .line 71
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-userNick"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->userNick:Ljava/lang/String;

    .line 72
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-session"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->session:Ljava/lang/String;

    .line 74
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-processName"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->processName:Ljava/lang/String;

    .line 75
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-appVersion"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->appVersion:Ljava/lang/String;

    .line 76
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "X-launcherMode"

    sget-object v4, Lcom/taobao/monitor/procedure/Header;->launcherMode:Ljava/lang/String;

    .line 77
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v2, "headers"

    .line 79
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "value"

    .line 81
    invoke-direct {p0, p1}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->valueJson(Lcom/taobao/monitor/procedure/Value;)Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    .line 83
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 86
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "NetworkDataUpdate"

    .line 87
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/taobao/monitor/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 89
    invoke-static {}, Lcom/taobao/monitor/network/NetworkSenderProxy;->instance()Lcom/taobao/monitor/network/NetworkSenderProxy;

    move-result-object v1

    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->topic()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1, v0}, Lcom/taobao/monitor/network/NetworkSenderProxy;->send(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "jsonObject",
            "map"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/json/JSONObject;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "*>;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x2

    .line 208
    invoke-direct {p0, p1, p2, v0}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;I)V

    return-void
.end method

.method private mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;I)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0
        }
        names = {
            "jsonObject",
            "map",
            "depth"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/json/JSONObject;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "*>;I)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    if-eqz p2, :cond_1

    if-gtz p3, :cond_0

    goto :goto_1

    .line 217
    :cond_0
    invoke-interface {p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 218
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 219
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    .line 220
    invoke-direct {p0, p1, v1, v0, p3}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->safePutJson(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;I)V

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method private safePutJson(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0
        }
        names = {
            "jsonObject",
            "key",
            "value"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x2

    .line 225
    invoke-direct {p0, p1, p2, p3, v0}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->safePutJson(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method private safePutJson(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;I)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0,
            0x0
        }
        names = {
            "jsonObject",
            "key",
            "value",
            "depth"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 229
    instance-of v0, p3, Ljava/lang/Integer;

    if-eqz v0, :cond_0

    .line 230
    check-cast p3, Ljava/lang/Integer;

    invoke-virtual {p3}, Ljava/lang/Integer;->intValue()I

    move-result p3

    invoke-virtual {p1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    goto/16 :goto_0

    .line 231
    :cond_0
    instance-of v0, p3, Ljava/lang/Long;

    if-eqz v0, :cond_1

    .line 232
    check-cast p3, Ljava/lang/Long;

    invoke-virtual {p3}, Ljava/lang/Long;->longValue()J

    move-result-wide p3

    invoke-virtual {p1, p2, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    goto :goto_0

    .line 233
    :cond_1
    instance-of v0, p3, Ljava/lang/Float;

    if-eqz v0, :cond_2

    .line 234
    check-cast p3, Ljava/lang/Float;

    invoke-virtual {p3}, Ljava/lang/Float;->floatValue()F

    move-result p3

    float-to-double p3, p3

    invoke-virtual {p1, p2, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    goto :goto_0

    .line 235
    :cond_2
    instance-of v0, p3, Ljava/lang/Double;

    if-eqz v0, :cond_3

    .line 236
    check-cast p3, Ljava/lang/Double;

    invoke-virtual {p3}, Ljava/lang/Double;->doubleValue()D

    move-result-wide p3

    invoke-virtual {p1, p2, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    goto :goto_0

    .line 237
    :cond_3
    instance-of v0, p3, Ljava/lang/Boolean;

    if-eqz v0, :cond_4

    .line 238
    check-cast p3, Ljava/lang/Boolean;

    invoke-virtual {p3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p3

    invoke-virtual {p1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    goto :goto_0

    .line 239
    :cond_4
    instance-of v0, p3, Ljava/lang/Character;

    if-eqz v0, :cond_5

    .line 240
    check-cast p3, Ljava/lang/Character;

    invoke-virtual {p3}, Ljava/lang/Character;->charValue()C

    move-result p3

    invoke-virtual {p1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    goto :goto_0

    .line 241
    :cond_5
    instance-of v0, p3, Ljava/lang/Short;

    if-eqz v0, :cond_6

    .line 242
    check-cast p3, Ljava/lang/Short;

    invoke-virtual {p3}, Ljava/lang/Short;->shortValue()S

    move-result p3

    invoke-virtual {p1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    goto :goto_0

    .line 243
    :cond_6
    instance-of v0, p3, Ljava/util/Map;

    if-eqz v0, :cond_7

    .line 244
    check-cast p3, Ljava/util/Map;

    invoke-interface {p3}, Ljava/util/Map;->size()I

    move-result v0

    if-eqz v0, :cond_8

    .line 245
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    add-int/lit8 p4, p4, -0x1

    .line 246
    invoke-direct {p0, v0, p3, p4}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;I)V

    .line 247
    invoke-virtual {p1, p2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    .line 250
    :cond_7
    invoke-virtual {p1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_8
    :goto_0
    return-void
.end method

.method private valueJson(Lcom/taobao/monitor/procedure/Value;)Lorg/json/JSONObject;
    .locals 9
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "value"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 94
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 97
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 100
    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->properties()Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 101
    invoke-interface {v2}, Ljava/util/Map;->size()I

    move-result v3

    if-eqz v3, :cond_1

    .line 102
    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 103
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 104
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    .line 105
    invoke-direct {p0, v1, v4, v3}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->safePutJson(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const/4 v2, 0x1

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    .line 111
    :goto_1
    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->bizs()Ljava/util/List;

    move-result-object v3

    const-string v4, "stages"

    if-eqz v3, :cond_6

    .line 112
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v5

    if-eqz v5, :cond_6

    .line 113
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 114
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/taobao/monitor/procedure/model/Biz;

    .line 115
    invoke-virtual {v5}, Lcom/taobao/monitor/procedure/model/Biz;->properties()Ljava/util/Map;

    move-result-object v6

    .line 116
    new-instance v7, Lorg/json/JSONObject;

    invoke-direct {v7}, Lorg/json/JSONObject;-><init>()V

    if-eqz v6, :cond_2

    .line 117
    invoke-interface {v6}, Ljava/util/Map;->size()I

    move-result v8

    if-eqz v8, :cond_2

    .line 118
    invoke-direct {p0, v7, v6}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;)V

    .line 121
    :cond_2
    invoke-virtual {v5}, Lcom/taobao/monitor/procedure/model/Biz;->abTest()Ljava/util/Map;

    move-result-object v6

    if-eqz v6, :cond_3

    .line 122
    invoke-interface {v6}, Ljava/util/Map;->size()I

    move-result v8

    if-eqz v8, :cond_3

    .line 123
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8}, Lorg/json/JSONObject;-><init>()V

    .line 124
    invoke-direct {p0, v8, v6}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;)V

    const-string v6, "abtest"

    .line 125
    invoke-virtual {v7, v6, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 128
    :cond_3
    invoke-virtual {v5}, Lcom/taobao/monitor/procedure/model/Biz;->stages()Ljava/util/Map;

    move-result-object v6

    if-eqz v6, :cond_4

    .line 129
    invoke-interface {v6}, Ljava/util/Map;->size()I

    move-result v8

    if-eqz v8, :cond_4

    .line 130
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8}, Lorg/json/JSONObject;-><init>()V

    .line 131
    invoke-direct {p0, v8, v6}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;)V

    .line 132
    invoke-virtual {v7, v4, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 135
    :cond_4
    invoke-virtual {v5}, Lcom/taobao/monitor/procedure/model/Biz;->bizID()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_2

    :cond_5
    const-string v3, "bizTags"

    .line 137
    invoke-virtual {v1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_3

    :cond_6
    if-eqz v2, :cond_7

    :goto_3
    const-string v2, "properties"

    .line 142
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 147
    :cond_7
    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->statistics()Ljava/util/Map;

    move-result-object v1

    .line 148
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    if-eqz v1, :cond_8

    .line 149
    invoke-interface {v1}, Ljava/util/Map;->size()I

    move-result v3

    if-eqz v3, :cond_8

    .line 150
    invoke-direct {p0, v2, v1}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;)V

    .line 153
    :cond_8
    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->counters()Ljava/util/Map;

    move-result-object v3

    if-eqz v3, :cond_9

    .line 154
    invoke-interface {v3}, Ljava/util/Map;->size()I

    move-result v5

    if-eqz v5, :cond_9

    .line 155
    invoke-direct {p0, v2, v3}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;)V

    .line 157
    :cond_9
    invoke-interface {v3}, Ljava/util/Map;->size()I

    move-result v3

    if-nez v3, :cond_a

    invoke-interface {v1}, Ljava/util/Map;->size()I

    move-result v1

    if-eqz v1, :cond_b

    :cond_a
    const-string v1, "stats"

    .line 158
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 163
    :cond_b
    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->events()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_d

    .line 164
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    if-eqz v2, :cond_d

    .line 165
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 166
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_4
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_c

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/taobao/monitor/procedure/model/Event;

    .line 167
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    const-string v6, "timestamp"

    .line 168
    invoke-virtual {v3}, Lcom/taobao/monitor/procedure/model/Event;->timestamp()J

    move-result-wide v7

    invoke-virtual {v5, v6, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v6, "name"

    .line 169
    invoke-virtual {v3}, Lcom/taobao/monitor/procedure/model/Event;->name()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 170
    invoke-virtual {v3}, Lcom/taobao/monitor/procedure/model/Event;->properties()Ljava/util/Map;

    move-result-object v3

    .line 171
    invoke-direct {p0, v5, v3}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->mapInsert2Json(Lorg/json/JSONObject;Ljava/util/Map;)V

    .line 172
    invoke-virtual {v2, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_4

    :cond_c
    const-string v1, "events"

    .line 174
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 180
    :cond_d
    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->stages()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_f

    .line 181
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    if-eqz v2, :cond_f

    .line 182
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 183
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_5
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_e

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/taobao/monitor/procedure/model/Stage;

    .line 184
    invoke-virtual {v3}, Lcom/taobao/monitor/procedure/model/Stage;->name()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3}, Lcom/taobao/monitor/procedure/model/Stage;->timestamp()J

    move-result-wide v6

    invoke-virtual {v2, v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    goto :goto_5

    .line 186
    :cond_e
    invoke-virtual {v0, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 191
    :cond_f
    invoke-virtual {p1}, Lcom/taobao/monitor/procedure/Value;->subValues()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_11

    .line 192
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-eqz v1, :cond_11

    .line 193
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 194
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_6
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_10

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/taobao/monitor/procedure/Value;

    .line 195
    invoke-direct {p0, v2}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->valueJson(Lcom/taobao/monitor/procedure/Value;)Lorg/json/JSONObject;

    move-result-object v3

    .line 196
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 197
    invoke-virtual {v2}, Lcom/taobao/monitor/procedure/Value;->topic()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 198
    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_6

    :cond_10
    const-string p1, "subProcedures"

    .line 200
    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_11
    return-object v0
.end method


# virtual methods
.method public begin(Lcom/taobao/monitor/procedure/Value;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "value"
        }
    .end annotation

    return-void
.end method

.method public end(Lcom/taobao/monitor/procedure/Value;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x0
        }
        names = {
            "value",
            "needUpload"
        }
    .end annotation

    if-eqz p2, :cond_0

    .line 44
    new-instance p2, Lcom/taobao/monitor/network/ProcedureLifecycleImpl$1;

    invoke-direct {p2, p0, p1}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl$1;-><init>(Lcom/taobao/monitor/network/ProcedureLifecycleImpl;Lcom/taobao/monitor/procedure/Value;)V

    invoke-static {p2}, Lcom/taobao/monitor/common/ThreadUtils;->start(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method public event(Lcom/taobao/monitor/procedure/Value;Lcom/taobao/monitor/procedure/model/Event;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "value",
            "event"
        }
    .end annotation

    return-void
.end method

.method public stage(Lcom/taobao/monitor/procedure/Value;Lcom/taobao/monitor/procedure/model/Stage;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "value",
            "stage"
        }
    .end annotation

    return-void
.end method
