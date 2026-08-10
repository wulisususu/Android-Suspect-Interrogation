.class public Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;
.super Ljava/lang/Object;
.source "LogUploadRequest.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field public allowNotWifi:Ljava/lang/Boolean;

.field public logFeatures:[Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;

.field public uploadId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.Protocol.LogUploadRequest"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->TAG:Ljava/lang/String;

    const/4 v0, 0x1

    .line 23
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->allowNotWifi:Ljava/lang/Boolean;

    return-void
.end method

.method private parseUploadInfos(Lcom/alibaba/fastjson/JSONArray;)[Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;
    .locals 6

    .line 50
    invoke-virtual {p1}, Lcom/alibaba/fastjson/JSONArray;->size()I

    move-result v0

    new-array v0, v0, [Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;

    const/4 v1, 0x0

    .line 51
    :goto_0
    invoke-virtual {p1}, Lcom/alibaba/fastjson/JSONArray;->size()I

    move-result v2

    if-ge v1, v2, :cond_4

    .line 52
    invoke-virtual {p1, v1}, Lcom/alibaba/fastjson/JSONArray;->getJSONObject(I)Lcom/alibaba/fastjson/JSONObject;

    move-result-object v2

    .line 53
    new-instance v3, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;

    invoke-direct {v3}, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;-><init>()V

    const-string v4, "appenderName"

    .line 55
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 56
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;->appenderName:Ljava/lang/String;

    :cond_0
    const-string v4, "suffix"

    .line 58
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 59
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;->suffix:Ljava/lang/String;

    :cond_1
    const-string v4, "maxHistory"

    .line 61
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 62
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->getInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v4

    iput-object v4, v3, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;->maxHistory:Ljava/lang/Integer;

    :cond_2
    const-string v4, "endTime"

    .line 65
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 66
    invoke-virtual {v2, v4}, Lcom/alibaba/fastjson/JSONObject;->getLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v2

    iput-object v2, v3, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;->endTime:Ljava/lang/Long;

    .line 69
    :cond_3
    aput-object v3, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_4
    return-object v0
.end method


# virtual methods
.method public parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 28
    check-cast p1, Lcom/alibaba/fastjson/JSONObject;

    const-string p2, "allowNotWifi"

    .line 29
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 30
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getBoolean(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->allowNotWifi:Ljava/lang/Boolean;

    :cond_0
    const-string p2, "uploadId"

    .line 33
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 34
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->uploadId:Ljava/lang/String;

    :cond_1
    const-string p2, "logFeatures"

    .line 37
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 38
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getJSONArray(Ljava/lang/String;)Lcom/alibaba/fastjson/JSONArray;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 39
    invoke-virtual {p1}, Lcom/alibaba/fastjson/JSONArray;->size()I

    move-result p2

    if-lez p2, :cond_2

    .line 40
    invoke-direct {p0, p1}, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->parseUploadInfos(Lcom/alibaba/fastjson/JSONArray;)[Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->logFeatures:[Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;

    :cond_2
    return-void
.end method
