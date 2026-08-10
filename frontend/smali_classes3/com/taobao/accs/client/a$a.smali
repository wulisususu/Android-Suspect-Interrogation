.class Lcom/taobao/accs/client/a$a;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/accs/client/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static final a:Lcom/taobao/accs/client/a;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 17
    new-instance v0, Lcom/taobao/accs/client/a;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/accs/client/a;-><init>(Lcom/taobao/accs/client/b;)V

    sput-object v0, Lcom/taobao/accs/client/a$a;->a:Lcom/taobao/accs/client/a;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a()Lcom/taobao/accs/client/a;
    .locals 1

    sget-object v0, Lcom/taobao/accs/client/a$a;->a:Lcom/taobao/accs/client/a;

    return-object v0
.end method
