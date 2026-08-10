.class public final enum Lcom/taobao/accs/utl/ALog$Level;
.super Ljava/lang/Enum;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/accs/utl/ALog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Level"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/taobao/accs/utl/ALog$Level;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/taobao/accs/utl/ALog$Level;

.field public static final enum D:Lcom/taobao/accs/utl/ALog$Level;

.field public static final enum E:Lcom/taobao/accs/utl/ALog$Level;

.field public static final enum I:Lcom/taobao/accs/utl/ALog$Level;

.field public static final enum L:Lcom/taobao/accs/utl/ALog$Level;

.field public static final enum V:Lcom/taobao/accs/utl/ALog$Level;

.field public static final enum W:Lcom/taobao/accs/utl/ALog$Level;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .line 15
    new-instance v0, Lcom/taobao/accs/utl/ALog$Level;

    const-string v1, "V"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/taobao/accs/utl/ALog$Level;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/taobao/accs/utl/ALog$Level;->V:Lcom/taobao/accs/utl/ALog$Level;

    .line 16
    new-instance v1, Lcom/taobao/accs/utl/ALog$Level;

    const-string v2, "D"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lcom/taobao/accs/utl/ALog$Level;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    .line 17
    new-instance v2, Lcom/taobao/accs/utl/ALog$Level;

    const-string v3, "I"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4}, Lcom/taobao/accs/utl/ALog$Level;-><init>(Ljava/lang/String;I)V

    sput-object v2, Lcom/taobao/accs/utl/ALog$Level;->I:Lcom/taobao/accs/utl/ALog$Level;

    .line 18
    new-instance v3, Lcom/taobao/accs/utl/ALog$Level;

    const-string v4, "W"

    const/4 v5, 0x3

    invoke-direct {v3, v4, v5}, Lcom/taobao/accs/utl/ALog$Level;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lcom/taobao/accs/utl/ALog$Level;->W:Lcom/taobao/accs/utl/ALog$Level;

    .line 19
    new-instance v4, Lcom/taobao/accs/utl/ALog$Level;

    const-string v5, "E"

    const/4 v6, 0x4

    invoke-direct {v4, v5, v6}, Lcom/taobao/accs/utl/ALog$Level;-><init>(Ljava/lang/String;I)V

    sput-object v4, Lcom/taobao/accs/utl/ALog$Level;->E:Lcom/taobao/accs/utl/ALog$Level;

    .line 20
    new-instance v5, Lcom/taobao/accs/utl/ALog$Level;

    const-string v6, "L"

    const/4 v7, 0x5

    invoke-direct {v5, v6, v7}, Lcom/taobao/accs/utl/ALog$Level;-><init>(Ljava/lang/String;I)V

    sput-object v5, Lcom/taobao/accs/utl/ALog$Level;->L:Lcom/taobao/accs/utl/ALog$Level;

    filled-new-array/range {v0 .. v5}, [Lcom/taobao/accs/utl/ALog$Level;

    move-result-object v0

    sput-object v0, Lcom/taobao/accs/utl/ALog$Level;->$VALUES:[Lcom/taobao/accs/utl/ALog$Level;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 14
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/taobao/accs/utl/ALog$Level;
    .locals 1

    const-class v0, Lcom/taobao/accs/utl/ALog$Level;

    .line 14
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/taobao/accs/utl/ALog$Level;

    return-object p0
.end method

.method public static values()[Lcom/taobao/accs/utl/ALog$Level;
    .locals 1

    sget-object v0, Lcom/taobao/accs/utl/ALog$Level;->$VALUES:[Lcom/taobao/accs/utl/ALog$Level;

    .line 14
    invoke-virtual {v0}, [Lcom/taobao/accs/utl/ALog$Level;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/taobao/accs/utl/ALog$Level;

    return-object v0
.end method
