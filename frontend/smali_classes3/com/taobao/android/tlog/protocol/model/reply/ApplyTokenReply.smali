.class public Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;
.super Ljava/lang/Object;
.source "ApplyTokenReply.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field public tokenInfos:[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

.field public tokenType:Ljava/lang/String;

.field public uploadId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.Protocol.ApplyTokenReplyParser"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;->TAG:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 34
    check-cast p1, Lcom/alibaba/fastjson/JSONObject;

    const-string p2, "uploadId"

    .line 36
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 37
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;->uploadId:Ljava/lang/String;

    :cond_0
    const-string p2, "tokenType"

    .line 40
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 41
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;->tokenType:Ljava/lang/String;

    :cond_1
    const-string p2, "tokenInfos"

    .line 44
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 45
    invoke-virtual {p1, p2}, Lcom/alibaba/fastjson/JSONObject;->getJSONArray(Ljava/lang/String;)Lcom/alibaba/fastjson/JSONArray;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 46
    invoke-virtual {p1}, Lcom/alibaba/fastjson/JSONArray;->size()I

    move-result p2

    if-lez p2, :cond_2

    .line 47
    invoke-static {p1}, Lcom/taobao/android/tlog/protocol/model/reply/ParseHelper;->parseUploadInfos(Lcom/alibaba/fastjson/JSONArray;)[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;->tokenInfos:[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    :cond_2
    return-void
.end method
