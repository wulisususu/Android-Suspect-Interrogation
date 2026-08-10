.class public Lcom/taobao/monitor/network/NetworkSenderProxy;
.super Ljava/lang/Object;
.source "NetworkSenderProxy.java"

# interfaces
.implements Lcom/taobao/monitor/network/INetworkSender;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/network/NetworkSenderProxy$Holder;
    }
.end annotation


# instance fields
.field private sender:Lcom/taobao/monitor/network/INetworkSender;


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 5
    new-instance v0, Lcom/taobao/monitor/network/NetworkSenderProxy$1;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/network/NetworkSenderProxy$1;-><init>(Lcom/taobao/monitor/network/NetworkSenderProxy;)V

    iput-object v0, p0, Lcom/taobao/monitor/network/NetworkSenderProxy;->sender:Lcom/taobao/monitor/network/INetworkSender;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/network/NetworkSenderProxy$1;)V
    .locals 0

    .line 3
    invoke-direct {p0}, Lcom/taobao/monitor/network/NetworkSenderProxy;-><init>()V

    return-void
.end method

.method public static instance()Lcom/taobao/monitor/network/NetworkSenderProxy;
    .locals 1

    .line 15
    sget-object v0, Lcom/taobao/monitor/network/NetworkSenderProxy$Holder;->INSTANCE:Lcom/taobao/monitor/network/NetworkSenderProxy;

    return-object v0
.end method


# virtual methods
.method public send(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
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

    iget-object v0, p0, Lcom/taobao/monitor/network/NetworkSenderProxy;->sender:Lcom/taobao/monitor/network/INetworkSender;

    if-eqz v0, :cond_0

    .line 26
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/network/INetworkSender;->send(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public setSender(Lcom/taobao/monitor/network/INetworkSender;)Lcom/taobao/monitor/network/NetworkSenderProxy;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "sender"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/network/NetworkSenderProxy;->sender:Lcom/taobao/monitor/network/INetworkSender;

    return-object p0
.end method
