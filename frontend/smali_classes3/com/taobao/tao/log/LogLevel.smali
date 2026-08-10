.class public final enum Lcom/taobao/tao/log/LogLevel;
.super Ljava/lang/Enum;
.source "LogLevel.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/taobao/tao/log/LogLevel;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/taobao/tao/log/LogLevel;

.field public static final enum ALL:Lcom/taobao/tao/log/LogLevel;

.field public static final enum D:Lcom/taobao/tao/log/LogLevel;

.field public static final enum E:Lcom/taobao/tao/log/LogLevel;

.field public static final enum F:Lcom/taobao/tao/log/LogLevel;

.field public static final enum I:Lcom/taobao/tao/log/LogLevel;

.field public static final enum L:Lcom/taobao/tao/log/LogLevel;

.field public static final enum N:Lcom/taobao/tao/log/LogLevel;

.field public static final enum V:Lcom/taobao/tao/log/LogLevel;

.field public static final enum W:Lcom/taobao/tao/log/LogLevel;


# instance fields
.field private index:I

.field private name:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 12

    .line 9
    new-instance v0, Lcom/taobao/tao/log/LogLevel;

    const-string v1, "ALL"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v1, v2}, Lcom/taobao/tao/log/LogLevel;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v0, Lcom/taobao/tao/log/LogLevel;->ALL:Lcom/taobao/tao/log/LogLevel;

    new-instance v1, Lcom/taobao/tao/log/LogLevel;

    const-string v3, "V"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4, v3, v2}, Lcom/taobao/tao/log/LogLevel;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v1, Lcom/taobao/tao/log/LogLevel;->V:Lcom/taobao/tao/log/LogLevel;

    new-instance v2, Lcom/taobao/tao/log/LogLevel;

    const-string v3, "D"

    const/4 v5, 0x2

    invoke-direct {v2, v3, v5, v3, v4}, Lcom/taobao/tao/log/LogLevel;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v2, Lcom/taobao/tao/log/LogLevel;->D:Lcom/taobao/tao/log/LogLevel;

    new-instance v3, Lcom/taobao/tao/log/LogLevel;

    const-string v4, "I"

    const/4 v6, 0x3

    invoke-direct {v3, v4, v6, v4, v5}, Lcom/taobao/tao/log/LogLevel;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v3, Lcom/taobao/tao/log/LogLevel;->I:Lcom/taobao/tao/log/LogLevel;

    new-instance v4, Lcom/taobao/tao/log/LogLevel;

    const-string v5, "W"

    const/4 v7, 0x4

    invoke-direct {v4, v5, v7, v5, v6}, Lcom/taobao/tao/log/LogLevel;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v4, Lcom/taobao/tao/log/LogLevel;->W:Lcom/taobao/tao/log/LogLevel;

    new-instance v5, Lcom/taobao/tao/log/LogLevel;

    const-string v6, "E"

    const/4 v8, 0x5

    invoke-direct {v5, v6, v8, v6, v7}, Lcom/taobao/tao/log/LogLevel;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v5, Lcom/taobao/tao/log/LogLevel;->E:Lcom/taobao/tao/log/LogLevel;

    new-instance v6, Lcom/taobao/tao/log/LogLevel;

    const-string v7, "F"

    const/4 v9, 0x6

    invoke-direct {v6, v7, v9, v7, v8}, Lcom/taobao/tao/log/LogLevel;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v6, Lcom/taobao/tao/log/LogLevel;->F:Lcom/taobao/tao/log/LogLevel;

    new-instance v7, Lcom/taobao/tao/log/LogLevel;

    const-string v8, "N"

    const/4 v10, 0x7

    invoke-direct {v7, v8, v10, v8, v9}, Lcom/taobao/tao/log/LogLevel;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v7, Lcom/taobao/tao/log/LogLevel;->N:Lcom/taobao/tao/log/LogLevel;

    new-instance v8, Lcom/taobao/tao/log/LogLevel;

    const-string v10, "L"

    const/16 v11, 0x8

    invoke-direct {v8, v10, v11, v10, v9}, Lcom/taobao/tao/log/LogLevel;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v8, Lcom/taobao/tao/log/LogLevel;->L:Lcom/taobao/tao/log/LogLevel;

    filled-new-array/range {v0 .. v8}, [Lcom/taobao/tao/log/LogLevel;

    move-result-object v0

    sput-object v0, Lcom/taobao/tao/log/LogLevel;->$VALUES:[Lcom/taobao/tao/log/LogLevel;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "I)V"
        }
    .end annotation

    .line 14
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/taobao/tao/log/LogLevel;->name:Ljava/lang/String;

    iput p4, p0, Lcom/taobao/tao/log/LogLevel;->index:I

    return-void
.end method

.method protected static getName(I)Ljava/lang/String;
    .locals 5

    .line 29
    invoke-static {}, Lcom/taobao/tao/log/LogLevel;->values()[Lcom/taobao/tao/log/LogLevel;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 30
    invoke-virtual {v3}, Lcom/taobao/tao/log/LogLevel;->getIndex()I

    move-result v4

    if-ne v4, p0, :cond_0

    .line 31
    iget-object p0, v3, Lcom/taobao/tao/log/LogLevel;->name:Ljava/lang/String;

    return-object p0

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/taobao/tao/log/LogLevel;
    .locals 1

    const-class v0, Lcom/taobao/tao/log/LogLevel;

    .line 7
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/taobao/tao/log/LogLevel;

    return-object p0
.end method

.method public static values()[Lcom/taobao/tao/log/LogLevel;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/LogLevel;->$VALUES:[Lcom/taobao/tao/log/LogLevel;

    .line 7
    invoke-virtual {v0}, [Lcom/taobao/tao/log/LogLevel;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/taobao/tao/log/LogLevel;

    return-object v0
.end method


# virtual methods
.method protected getIndex()I
    .locals 1

    iget v0, p0, Lcom/taobao/tao/log/LogLevel;->index:I

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/LogLevel;->name:Ljava/lang/String;

    return-object v0
.end method
