.class Lcom/taobao/tao/log/CommandDataCenter$a;
.super Ljava/lang/Object;
.source "CommandDataCenter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/CommandDataCenter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static a:Lcom/taobao/tao/log/CommandDataCenter;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 21
    new-instance v0, Lcom/taobao/tao/log/CommandDataCenter;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/tao/log/CommandDataCenter;-><init>(Lcom/taobao/tao/log/CommandDataCenter$1;)V

    sput-object v0, Lcom/taobao/tao/log/CommandDataCenter$a;->a:Lcom/taobao/tao/log/CommandDataCenter;

    return-void
.end method

.method static synthetic a()Lcom/taobao/tao/log/CommandDataCenter;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/CommandDataCenter$a;->a:Lcom/taobao/tao/log/CommandDataCenter;

    return-object v0
.end method
