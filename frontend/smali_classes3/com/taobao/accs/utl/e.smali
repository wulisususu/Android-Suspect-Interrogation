.class public Lcom/taobao/accs/utl/e;
.super Lcom/taobao/accs/utl/RomInfoCollector;
.source "Taobao"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Lcom/taobao/accs/utl/RomInfoCollector;-><init>()V

    return-void
.end method


# virtual methods
.method public collect()Ljava/lang/String;
    .locals 2

    .line 13
    invoke-static {}, Lcom/taobao/accs/utl/UtilityImpl;->g()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    .line 14
    iget-object v1, p0, Lcom/taobao/accs/utl/e;->mNextCollector:Lcom/taobao/accs/utl/RomInfoCollector;

    if-eqz v1, :cond_0

    .line 15
    iget-object v0, p0, Lcom/taobao/accs/utl/e;->mNextCollector:Lcom/taobao/accs/utl/RomInfoCollector;

    invoke-virtual {v0}, Lcom/taobao/accs/utl/RomInfoCollector;->collect()Ljava/lang/String;

    move-result-object v0

    :cond_0
    return-object v0
.end method
