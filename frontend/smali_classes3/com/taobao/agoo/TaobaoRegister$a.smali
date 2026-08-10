.class Lcom/taobao/agoo/TaobaoRegister$a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lcom/taobao/agoo/TaobaoRegister$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/agoo/TaobaoRegister;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# instance fields
.field private final a:Ljava/lang/String;


# direct methods
.method private constructor <init>(Ljava/lang/String;)V
    .locals 0

    .line 241
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$a;->a:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Lcom/taobao/agoo/c;)V
    .locals 0

    .line 238
    invoke-direct {p0, p1}, Lcom/taobao/agoo/TaobaoRegister$a;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$a;->a:Ljava/lang/String;

    .line 247
    invoke-static {p1, p2, v0}, Lcom/taobao/agoo/a/a/a;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object p1

    return-object p1
.end method
