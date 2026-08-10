.class Lcom/taobao/monitor/network/NetworkSenderProxy$1;
.super Ljava/lang/Object;
.source "NetworkSenderProxy.java"

# interfaces
.implements Lcom/taobao/monitor/network/INetworkSender;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/network/NetworkSenderProxy;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/network/NetworkSenderProxy;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/network/NetworkSenderProxy;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            "this$0"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/network/NetworkSenderProxy$1;->this$0:Lcom/taobao/monitor/network/NetworkSenderProxy;

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public send(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "topic",
            "content"
        }
    .end annotation

    return-void
.end method
