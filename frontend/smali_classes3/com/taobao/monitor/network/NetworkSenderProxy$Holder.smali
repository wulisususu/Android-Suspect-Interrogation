.class Lcom/taobao/monitor/network/NetworkSenderProxy$Holder;
.super Ljava/lang/Object;
.source "NetworkSenderProxy.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/network/NetworkSenderProxy;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Holder"
.end annotation


# static fields
.field static final INSTANCE:Lcom/taobao/monitor/network/NetworkSenderProxy;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 31
    new-instance v0, Lcom/taobao/monitor/network/NetworkSenderProxy;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/monitor/network/NetworkSenderProxy;-><init>(Lcom/taobao/monitor/network/NetworkSenderProxy$1;)V

    sput-object v0, Lcom/taobao/monitor/network/NetworkSenderProxy$Holder;->INSTANCE:Lcom/taobao/monitor/network/NetworkSenderProxy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
