.class public Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;
.super Lcom/taobao/android/tlog/protocol/model/request/base/LogRequestBase;
.source "StartupRequest.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field public appVersion:Ljava/lang/String;

.field public brand:Ljava/lang/String;

.field public clientTime:Ljava/lang/Long;

.field public deviceModel:Ljava/lang/String;

.field public geo:Ljava/lang/String;

.field public ip:Ljava/lang/String;

.field public osPlatform:Ljava/lang/String;

.field public osVersion:Ljava/lang/String;

.field private requestType:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 17
    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/request/base/LogRequestBase;-><init>()V

    const-string v0, "TLOG.Protocol.StartupRequest"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->TAG:Ljava/lang/String;

    const-string v0, "REQUEST"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->requestType:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public build()Lcom/taobao/android/tlog/protocol/model/RequestResult;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 40
    invoke-static {}, Lcom/taobao/android/tlog/protocol/utils/RandomIdUtils;->getRandomId()Ljava/lang/String;

    move-result-object v3

    .line 41
    invoke-static {}, Lcom/taobao/android/tlog/protocol/utils/RandomIdUtils;->getRandomId()Ljava/lang/String;

    move-result-object v4

    .line 42
    invoke-static {}, Lcom/taobao/android/tlog/protocol/utils/RandomIdUtils;->getRandomId()Ljava/lang/String;

    move-result-object v5

    .line 45
    invoke-static {p0, v3, v4}, Lcom/taobao/android/tlog/protocol/model/request/BuilderHelper;->buildRequestHeader(Lcom/taobao/android/tlog/protocol/model/request/base/LogRequestBase;Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object v1

    .line 48
    new-instance v0, Lcom/alibaba/fastjson/JSONObject;

    invoke-direct {v0}, Lcom/alibaba/fastjson/JSONObject;-><init>()V

    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->appVersion:Ljava/lang/String;

    if-eqz v2, :cond_0

    const-string v6, "appVersion"

    .line 50
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->deviceModel:Ljava/lang/String;

    if-eqz v2, :cond_1

    const-string v6, "deviceModel"

    .line 53
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 55
    :cond_1
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->user:Ljava/lang/String;

    if-eqz v2, :cond_2

    const-string v2, "userNick"

    .line 56
    iget-object v6, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->user:Ljava/lang/String;

    invoke-virtual {v0, v2, v6}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->osPlatform:Ljava/lang/String;

    if-eqz v2, :cond_3

    const-string v6, "osPlatform"

    .line 59
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->osVersion:Ljava/lang/String;

    if-eqz v2, :cond_4

    const-string v6, "osVersion"

    .line 62
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_4
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->geo:Ljava/lang/String;

    if-eqz v2, :cond_5

    const-string v6, "geo"

    .line 65
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_5
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->clientTime:Ljava/lang/Long;

    if-eqz v2, :cond_6

    const-string v6, "clientTime"

    .line 68
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_6
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->brand:Ljava/lang/String;

    if-eqz v2, :cond_7

    const-string v6, "brand"

    .line 71
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_7
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->ip:Ljava/lang/String;

    if-eqz v2, :cond_8

    const-string v6, "ip"

    .line 74
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 76
    :cond_8
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->tokenType:Ljava/lang/String;

    if-eqz v2, :cond_9

    const-string v2, "tokenType"

    .line 77
    iget-object v6, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->tokenType:Ljava/lang/String;

    invoke-virtual {v0, v2, v6}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 79
    :cond_9
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->tokenInfo:Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    if-eqz v2, :cond_a

    const-string v2, "tokenInfo"

    .line 80
    iget-object v6, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->tokenInfo:Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    invoke-virtual {v0, v2, v6}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_a
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/StartupRequest;->requestType:Ljava/lang/String;

    .line 84
    invoke-static/range {v0 .. v5}, Lcom/taobao/android/tlog/protocol/model/request/BuilderHelper;->buildRequestResult(Lcom/alibaba/fastjson/JSONObject;Lcom/alibaba/fastjson/JSONObject;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/android/tlog/protocol/model/RequestResult;

    move-result-object v0

    return-object v0
.end method
