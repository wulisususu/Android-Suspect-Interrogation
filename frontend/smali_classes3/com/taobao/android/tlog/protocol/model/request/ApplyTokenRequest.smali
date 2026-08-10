.class public Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;
.super Lcom/taobao/android/tlog/protocol/model/request/base/LogRequestBase;
.source "ApplyTokenRequest.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field public fileInfos:[Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;

.field private requestType:Ljava/lang/String;

.field public uploadId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/request/base/LogRequestBase;-><init>()V

    const-string v0, "TLOG.Protocol.ApplyTokenRequestInfo"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->TAG:Ljava/lang/String;

    const-string v0, "REQUEST"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->requestType:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public build()Lcom/taobao/android/tlog/protocol/model/RequestResult;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 37
    invoke-static {}, Lcom/taobao/android/tlog/protocol/utils/RandomIdUtils;->getRandomId()Ljava/lang/String;

    move-result-object v3

    .line 38
    invoke-static {}, Lcom/taobao/android/tlog/protocol/utils/RandomIdUtils;->getRandomId()Ljava/lang/String;

    move-result-object v4

    .line 41
    invoke-static {p0, v3, v4}, Lcom/taobao/android/tlog/protocol/model/request/BuilderHelper;->buildRequestHeader(Lcom/taobao/android/tlog/protocol/model/request/base/LogRequestBase;Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object v1

    .line 44
    new-instance v0, Lcom/alibaba/fastjson/JSONObject;

    invoke-direct {v0}, Lcom/alibaba/fastjson/JSONObject;-><init>()V

    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->uploadId:Ljava/lang/String;

    if-eqz v2, :cond_0

    const-string v5, "uploadId"

    .line 46
    invoke-virtual {v0, v5, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 48
    :cond_0
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->tokenType:Ljava/lang/String;

    if-eqz v2, :cond_1

    const-string v2, "tokenType"

    .line 49
    iget-object v5, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->tokenType:Ljava/lang/String;

    invoke-virtual {v0, v2, v5}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 51
    :cond_1
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->tokenInfo:Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    if-eqz v2, :cond_2

    const-string v2, "tokenInfo"

    .line 52
    iget-object v5, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->tokenInfo:Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    invoke-virtual {v0, v2, v5}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->fileInfos:[Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;

    if-eqz v2, :cond_3

    const-string v5, "fileInfos"

    .line 55
    invoke-static {v2}, Lcom/taobao/android/tlog/protocol/model/request/BuilderHelper;->buildFileInfos([Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;)Lcom/alibaba/fastjson/JSONArray;

    move-result-object v2

    invoke-virtual {v0, v5, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->requestType:Ljava/lang/String;

    iget-object v5, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyTokenRequest;->uploadId:Ljava/lang/String;

    .line 59
    invoke-static/range {v0 .. v5}, Lcom/taobao/android/tlog/protocol/model/request/BuilderHelper;->buildRequestResult(Lcom/alibaba/fastjson/JSONObject;Lcom/alibaba/fastjson/JSONObject;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/android/tlog/protocol/model/RequestResult;

    move-result-object v0

    return-object v0
.end method
