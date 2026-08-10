.class final Lcom/taobao/network/lifecycle/NetworkLifecycleManager$Holder;
.super Ljava/lang/Object;
.source "NetworkLifecycleManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/network/lifecycle/NetworkLifecycleManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Holder"
.end annotation


# static fields
.field private static final INSTANCE:Lcom/taobao/network/lifecycle/NetworkLifecycleManager;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 117
    new-instance v0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;-><init>(Lcom/taobao/network/lifecycle/NetworkLifecycleManager$1;)V

    sput-object v0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager$Holder;->INSTANCE:Lcom/taobao/network/lifecycle/NetworkLifecycleManager;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 116
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lcom/taobao/network/lifecycle/NetworkLifecycleManager;
    .locals 1

    sget-object v0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager$Holder;->INSTANCE:Lcom/taobao/network/lifecycle/NetworkLifecycleManager;

    return-object v0
.end method
