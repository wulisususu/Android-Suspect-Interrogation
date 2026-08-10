.class public Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;
.super Lcom/taobao/android/tlog/protocol/model/request/base/LogRequestBase;
.source "ApplyUploadRequest.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field public bizAliyunComment:Ljava/lang/String;

.field public bizCode:Ljava/lang/String;

.field public bizType:Ljava/lang/String;

.field public debugType:Ljava/lang/String;

.field public extraInfo:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field public fileInfos:[Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;

.field private requestType:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/request/base/LogRequestBase;-><init>()V

    const-string v0, "TLOG.Protocol.ApplyUploadRequestInfo"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->TAG:Ljava/lang/String;

    const-string v0, "REQUEST"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->requestType:Ljava/lang/String;

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

    .line 42
    invoke-static {}, Lcom/taobao/android/tlog/protocol/utils/RandomIdUtils;->getRandomId()Ljava/lang/String;

    move-result-object v3

    .line 43
    invoke-static {}, Lcom/taobao/android/tlog/protocol/utils/RandomIdUtils;->getRandomId()Ljava/lang/String;

    move-result-object v4

    .line 44
    invoke-static {}, Lcom/taobao/android/tlog/protocol/utils/RandomIdUtils;->getRandomId()Ljava/lang/String;

    move-result-object v5

    .line 47
    invoke-static {p0, v3, v4}, Lcom/taobao/android/tlog/protocol/model/request/BuilderHelper;->buildRequestHeader(Lcom/taobao/android/tlog/protocol/model/request/base/LogRequestBase;Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object v1

    .line 50
    new-instance v0, Lcom/alibaba/fastjson/JSONObject;

    invoke-direct {v0}, Lcom/alibaba/fastjson/JSONObject;-><init>()V

    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->bizAliyunComment:Ljava/lang/String;

    if-eqz v2, :cond_0

    const-string v6, "bizAliyunComment"

    .line 52
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->debugType:Ljava/lang/String;

    if-eqz v2, :cond_1

    const-string v6, "debugType"

    .line 56
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->bizType:Ljava/lang/String;

    if-eqz v2, :cond_2

    const-string v6, "bizType"

    .line 59
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->bizCode:Ljava/lang/String;

    if-eqz v2, :cond_3

    const-string v6, "bizCode"

    .line 62
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 64
    :cond_3
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->tokenType:Ljava/lang/String;

    if-eqz v2, :cond_4

    const-string v2, "tokenType"

    .line 65
    iget-object v6, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->tokenType:Ljava/lang/String;

    invoke-virtual {v0, v2, v6}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 67
    :cond_4
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->tokenInfo:Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    if-eqz v2, :cond_5

    const-string v2, "tokenInfo"

    .line 68
    iget-object v6, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->tokenInfo:Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    invoke-virtual {v0, v2, v6}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_5
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->fileInfos:[Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;

    if-eqz v2, :cond_6

    const-string v6, "fileInfos"

    .line 71
    invoke-static {v2}, Lcom/taobao/android/tlog/protocol/model/request/BuilderHelper;->buildFileInfos([Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;)Lcom/alibaba/fastjson/JSONArray;

    move-result-object v2

    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_6
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->extraInfo:Ljava/util/Map;

    if-eqz v2, :cond_7

    const-string v6, "extraInfo"

    .line 74
    invoke-virtual {v0, v6, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_7
    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/request/ApplyUploadRequest;->requestType:Ljava/lang/String;

    .line 78
    invoke-static/range {v0 .. v5}, Lcom/taobao/android/tlog/protocol/model/request/BuilderHelper;->buildRequestResult(Lcom/alibaba/fastjson/JSONObject;Lcom/alibaba/fastjson/JSONObject;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/android/tlog/protocol/model/RequestResult;

    move-result-object v0

    return-object v0
.end method
