.class public Lcom/taobao/android/tlog/protocol/model/CommandInfo;
.super Ljava/lang/Object;
.source "CommandInfo.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field public appId:Ljava/lang/String;

.field public appKey:Ljava/lang/String;

.field public data:Lcom/alibaba/fastjson/JSON;

.field public forward:[B

.field public msgType:Ljava/lang/String;

.field public opCode:Ljava/lang/String;

.field public replyCode:Ljava/lang/String;

.field public replyId:Ljava/lang/String;

.field public replyMessage:Ljava/lang/String;

.field public requestId:Ljava/lang/String;

.field public serviceId:Ljava/lang/String;

.field public sessionId:Ljava/lang/String;

.field public userId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
