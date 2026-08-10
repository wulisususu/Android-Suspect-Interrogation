.class public Lcom/taobao/tao/log/message/MessageReponse;
.super Ljava/lang/Object;
.source "MessageReponse.java"


# instance fields
.field public dataId:Ljava/lang/String;

.field public result:Ljava/lang/String;

.field public serviceId:Ljava/lang/String;

.field public userId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/tao/log/message/MessageReponse;->result:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/message/MessageReponse;->serviceId:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/message/MessageReponse;->dataId:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/message/MessageReponse;->userId:Ljava/lang/String;

    return-void
.end method
