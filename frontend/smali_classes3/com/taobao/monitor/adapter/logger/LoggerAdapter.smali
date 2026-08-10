.class public Lcom/taobao/monitor/adapter/logger/LoggerAdapter;
.super Ljava/lang/Object;
.source "LoggerAdapter.java"

# interfaces
.implements Lcom/taobao/monitor/impl/logger/IDataLogger;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/taobao/monitor/adapter/logger/LoggerAdapter;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 11
    invoke-direct {p0, p1}, Lcom/taobao/monitor/adapter/logger/LoggerAdapter;->format2String([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private varargs format2String([Ljava/lang/Object;)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "objects"
        }
    .end annotation

    if-eqz p1, :cond_3

    .line 28
    array-length v0, p1

    if-eqz v0, :cond_3

    .line 29
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 30
    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p1, v2

    if-eqz v3, :cond_1

    .line 33
    instance-of v4, v3, Ljava/util/Map;

    if-eqz v4, :cond_0

    .line 34
    check-cast v3, Ljava/util/Map;

    invoke-direct {p0, v3}, Lcom/taobao/monitor/adapter/logger/LoggerAdapter;->map2Json(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 36
    :cond_0
    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_1
    const-string v4, "->"

    .line 38
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 41
    :cond_2
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_3
    const-string p1, ""

    return-object p1
.end method

.method private map2Json(Ljava/util/Map;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "map"
        }
    .end annotation

    .line 47
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    .line 48
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public varargs log(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10
        }
        names = {
            "tag",
            "msg"
        }
    .end annotation

    .line 15
    new-instance v0, Lcom/taobao/monitor/adapter/logger/LoggerAdapter$1;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/monitor/adapter/logger/LoggerAdapter$1;-><init>(Lcom/taobao/monitor/adapter/logger/LoggerAdapter;Ljava/lang/String;[Ljava/lang/Object;)V

    invoke-static {v0}, Lcom/taobao/monitor/common/ThreadUtils;->start(Ljava/lang/Runnable;)V

    return-void
.end method
