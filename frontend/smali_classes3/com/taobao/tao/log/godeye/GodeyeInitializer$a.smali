.class Lcom/taobao/tao/log/godeye/GodeyeInitializer$a;
.super Ljava/lang/Object;
.source "GodeyeInitializer.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/godeye/GodeyeInitializer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static a:Lcom/taobao/tao/log/godeye/GodeyeInitializer;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 34
    new-instance v0, Lcom/taobao/tao/log/godeye/GodeyeInitializer;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;-><init>(Lcom/taobao/tao/log/godeye/GodeyeInitializer$1;)V

    sput-object v0, Lcom/taobao/tao/log/godeye/GodeyeInitializer$a;->a:Lcom/taobao/tao/log/godeye/GodeyeInitializer;

    return-void
.end method

.method static synthetic a()Lcom/taobao/tao/log/godeye/GodeyeInitializer;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/godeye/GodeyeInitializer$a;->a:Lcom/taobao/tao/log/godeye/GodeyeInitializer;

    return-object v0
.end method
